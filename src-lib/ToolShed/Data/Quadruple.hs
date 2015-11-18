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

 [@DESCRIPTION@]	Miscellaneous operations on quadruples.

 [@CAVEAT@]	Import fully qualified, since some identifiers clash with 'ToolShed.Data.Triple'.
-}

module ToolShed.Data.Quadruple(
-- * Functions
	curry4,
	uncurry4,
-- ** Accessors
	getFirst,
	getSecond,
	getThird,
	getFourth
) where

-- | Extends the concept of 'Data.Tuple.curry'.
curry4 :: ((a, b, c, d) -> result) -> a -> b -> c -> d -> result
curry4 f a b c d	= f (a, b, c, d)

-- | Extends the concept of 'Data.Tuple.uncurry'.
uncurry4 :: (a -> b -> c -> d -> result) -> (a, b, c, d) -> result
uncurry4 f (a, b, c, d)	= f a b c d

-- | Access the first datum from the specified quadruple.
getFirst :: (a, b, c, d) -> a
getFirst (a, _, _, _)	= a

-- | Access the second datum from the specified quadruple.
getSecond :: (a, b, c, d) -> b
getSecond (_, b, _, _)	= b

-- | Access the third datum from the specified quadruple.
getThird :: (a, b, c, d) -> c
getThird (_, _, c, _)	= c

-- | Access the fourth datum from the specified quadruple.
getFourth :: (a, b, c, d) -> d
getFourth (_, _, _, d)	= d

