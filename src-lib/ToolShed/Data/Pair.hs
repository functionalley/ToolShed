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

 [@DESCRIPTION@]	Miscellaneous operations on Pairs.
-}

module ToolShed.Data.Pair(
-- * Functions
	mirror
) where

import	Control.Arrow((***))

{- |
	* Apply the same transformation to both halves of a /Pair/.

	* CAVEAT: even though the function may be polymorphic, the pair is required to have identical types.
-}
mirror :: (a -> b) -> (a, a) -> (b, b)
mirror f	= f *** f

