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

 [@DESCRIPTION@]	Run-length encoder and decoder.
-}

module ToolShed.Data.List.Runlength(
-- * Types
-- ** Type-synonyms
	Code,
-- * Functions
	encode,
	decode,
-- ** Accessors
	getLength,
	getDatum
) where

import			Control.Arrow((&&&))
import qualified	Data.List

-- | Describes the number of consecutive equal items in a list.
type Code a	= (Int, a)

-- | Accessor.
getLength :: Code a -> Int
getLength	= fst

-- | Accessor.
getDatum :: Code a -> a
getDatum	= snd

-- | /Run-length/ encodes the specified list.
encode :: Eq a => [a] -> [Code a]
encode	= map (length &&& head) . Data.List.group

-- | Performs /run-length/ decoding to retrieve the original unencoded list.
decode :: [Code a] -> [a]
decode	= concatMap (uncurry replicate)

