{-
	Copyright (C) 2015 Dr. Alistair Ward

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

 [@DESCRIPTION@]	Provides a simple predicate.
-}

module ToolShed.Test.QuickCheck.Result(
-- * Functions
-- ** Predicates
	isSuccessful
) where

import qualified	Test.QuickCheck

-- | Check whether the specified result is successful.
isSuccessful :: Test.QuickCheck.Result -> Bool
isSuccessful Test.QuickCheck.Success {}	= True
isSuccessful _				= False
