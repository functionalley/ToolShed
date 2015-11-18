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

 [@DESCRIPTION@]	Miscellaneous operations on triples.

 [@CAVEAT@]	Import fully qualified, since some identifiers clash with 'ToolShed.Data.Quadruple'.
-}

module ToolShed.Data.Triple(
-- * Functions
	curry3,
	uncurry3,
-- ** Accessors
	getFirst,
	getSecond,
	getThird
) where

-- | Extends the concept of 'Data.Tuple.curry'.
curry3 :: ((a, b, c) -> result) -> a -> b -> c -> result
curry3 f a b c	= f (a, b, c)

-- | Extends the concept of 'Data.Tuple.uncurry'.
uncurry3 :: (a -> b -> c -> result) -> (a, b, c) -> result
uncurry3 f (a, b, c)	= f a b c

-- | Access the first datum from the specified triple.
getFirst :: (a, b, c) -> a
getFirst (a, _, _)	= a

-- | Access the second datum from the specified triple.
getSecond :: (a, b, c) -> b
getSecond (_, b, _)	= b

-- | Access the third datum from the specified triple.
getThird :: (a, b, c) -> c
getThird (_, _, c)	= c

