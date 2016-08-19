{-
	Copyright (C) 2013 Dr. Alistair Ward

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

 [@DESCRIPTION@]

	* Additions to module "Data.Array.IArray".
-}

module ToolShed.Data.Array.IArray(
-- * Functions
	adjust
) where

import qualified	Data.Array.IArray
import			Data.Array.IArray((!), (//))

-- | Update a single element of the specified array.
adjust :: (
	Data.Array.IArray.Ix		i,
	Data.Array.IArray.IArray	a e
 )
	=> (e -> e)	-- ^ Mutator.
	-> i		-- ^ Index.
	-> a i e
	-> a i e
adjust mutator i array	= array // [
	(
		i,
		mutator $ array ! i
	) -- Pair.
 ]
