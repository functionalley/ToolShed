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

 [@DESCRIPTION@]
-}

module ToolShed.Data.List.Splits(
-- * Types
-- ** Type-synonyms
--	Split,
-- * Functions
--	splitsFrom,
	splitsLeftFrom,
	splitsRightFrom
) where

-- | The polymorphic pair, resulting from splitting a list of arbitrary type.
type Split a	= ([a] {-left list-}, [a] {-right list-})

-- | Use the specified transformation, to generate a list of 'Split's, from the initial one.
splitsFrom
	:: (Split a -> Split a)	-- ^ The function used to transform one /split/ into the next.
	-> Int			-- ^ Index.
	-> [a]			-- ^ The polymorphic input list from which the /splits/ are generated.
	-> [Split a]		-- ^ The list of all required splits of the single input list.
splitsFrom transformation i
	| i < 0		= error $ "ToolShed.Data.List.Splits.splitsFrom:\tnegative starting-index; " ++ show i
	| otherwise	= iterate transformation . splitAt i

{- |
	* Create the set of all 'Split's, migrating left from the specified location.

	* CAVEAT: 'init' fails when 'fst' has been reduced to null.
-}
splitsLeftFrom
	:: Int		-- ^ Index.
	-> [a]		-- ^ The polymorphic input list from which the /splits/ are generated, as the index is stepped left
	-> [Split a]	-- ^ The list of all required splits of the single input list.
splitsLeftFrom	= splitsFrom (\(l, r) -> (init l, last l : r))

{- |
	* Create the set of all 'Split's, migrating right from the specified location.

	* CAVEAT: pattern-match against @ : @ fails, when 'snd' has been reduced to 'null'.
-}
splitsRightFrom
	:: Int		-- ^ Index.
	-> [a]		-- ^ The polymorphic input list from which the /splits/ are generated, as the index is stepped right.
	-> [Split a]	-- ^ The list of all required splits of the single input list.
splitsRightFrom	= splitsFrom (\(l, r : rs) -> (l ++ [r], rs))
