{-
	Copyright (C) 2010 Dr. Alistair Ward

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}
{- |
 [@AUTHOR@]	Dr. Alistair Ward

 [@DESCRIPTION@]	A class to define the simple interface, to which data which can self-validation, should conform.
-}

module ToolShed.SelfValidate(
-- * Type-classes
	SelfValidator(..),
-- ** Functions
	getFirstError,
	extractErrors
) where

import qualified	Data.Array.IArray
import qualified	Data.Map
import qualified	Data.Set

-- | The interface to which data which can self-validate should conform.
class SelfValidator v	where
	getErrors	:: v -> [String]	-- ^ Return either null, or the reasons why the data is invalid.

	isValid		:: v -> Bool		-- ^ The data which implements this interface should return 'True' if internally consistent.
	isValid	= null . getErrors	-- Default implementation.

instance (SelfValidator v) => SelfValidator (Maybe v)	where
	getErrors (Just v)	= getErrors v
	getErrors _		= []

instance (SelfValidator a, SelfValidator b) => SelfValidator (a, b)	where
	getErrors (x, y)	= getErrors x ++ getErrors y

instance (SelfValidator a, SelfValidator b, SelfValidator c) => SelfValidator (a, b, c)	where
	getErrors (x, y, z)	= getErrors x ++ getErrors y ++ getErrors z

instance SelfValidator v => SelfValidator [v]	where
	getErrors	= concatMap getErrors

instance SelfValidator v => SelfValidator (Data.Set.Set v)	where
	getErrors	= Data.Set.foldr ((++) . getErrors) []

instance SelfValidator v => SelfValidator (Data.Map.Map k v)	where
	getErrors	= Data.Map.foldr ((++) . getErrors) []

instance (Data.Array.IArray.Ix index, SelfValidator element) => SelfValidator (Data.Array.IArray.Array index element)	where
	getErrors	= concatMap getErrors . Data.Array.IArray.elems

-- | Returns the first error only (so only call on failure of 'isValid'), since subsequent tests may be based on invalid data.
getFirstError :: SelfValidator v => v -> String
getFirstError selfValidator
	| null errors	= error "ToolShed.SelfValidate.getFirstError:\tzero errors ?!"
	| otherwise	= head errors
	where
		errors	= getErrors selfValidator

-- | Extracts the failed tests from those specified.
extractErrors :: [(Bool, String)] -> [String]
extractErrors	= map snd . filter fst

