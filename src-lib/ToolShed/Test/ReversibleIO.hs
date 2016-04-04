{-
	Copyright (C) 2012 Dr. Alistair Ward

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

	* Facilitates testing of custom implementations of 'Read' & 'Show'.

	* CAVEAT: it doesn't actually do any IO.
-}

module ToolShed.Test.ReversibleIO(
-- * Functions
-- ** Predicates
	isReversible,
	readPrependedWhiteSpace,
	readTrailingGarbage
) where

-- | Checks that composing 'read' & 'show' is equivalent to the identity.
isReversible :: (Eq r, Read r, Show r) => r -> Bool
isReversible r	= read (show r) == r

-- | Checks whether 'read' can skip prepended white space; 'isReversible' is a prerequisite.
readPrependedWhiteSpace :: (Eq r, Read r, Show r) => r -> Bool
readPrependedWhiteSpace r	= read (" \t\r\n" ++ show r) == r

-- | Checks whether 'read' both copes with garbage following the valid input-data, & leaves it unchanged.
readTrailingGarbage :: (
	Eq	a,
	Read	a,
	Show	a
 )
	=> (Char -> Bool)	-- ^ Whether a character of garbage might reasonably be confused with valid data, & therefore should be dropped.
	-> a			-- ^ The datum to be written & read.
	-> String		-- ^ The text to follow the written datum.
	-> Bool
readTrailingGarbage predicate x s	= let
	s'	= dropWhile predicate s
 in case reads $ shows x s' of
	[pair]	-> pair == (x, s')
	_	-> False

