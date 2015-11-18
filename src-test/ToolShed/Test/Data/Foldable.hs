{-
	Copyright (C) 2012-2015 Dr. Alistair Ward

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

 [@DESCRIPTION@]	Defines /QuickCheck/-properties "ToolShed.Data.Foldable".
-}

module ToolShed.Test.Data.Foldable(
-- * Constants
	results
) where

import qualified	Data.List
import qualified	Data.Ord
import qualified	Data.Set
import qualified	ToolShed.Data.Foldable
import qualified	ToolShed.Data.List
import qualified	Test.QuickCheck

-- | The constant test-results for this data-type.
results :: IO [Test.QuickCheck.Result]
results	= sequence [
	Test.QuickCheck.quickCheckResult prop_gatherSet,
	Test.QuickCheck.quickCheckResult prop_gatherBy
 ] where
	prop_gatherSet :: Int -> Test.QuickCheck.Property
	prop_gatherSet n	= Test.QuickCheck.label "prop_gatherSet" . (== l) . concat . ToolShed.Data.Foldable.gather $ Data.Set.fromDistinctAscList l	where
		l	= [0 .. n `mod` 1024]

	prop_gatherBy :: [Int] -> Test.QuickCheck.Property
	prop_gatherBy l	= Test.QuickCheck.label "prop_gatherBy" $ map Data.List.sort (
		ToolShed.Data.Foldable.gatherBy even l
	 ) == (
		map Data.List.sort . Data.List.groupBy (ToolShed.Data.List.equalityBy even) $ Data.List.sortBy (Data.Ord.comparing even) l
	 )

