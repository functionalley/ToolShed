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

 [@DESCRIPTION@]	Defines /QuickCheck/-properties "ToolShed.Data.List.Splits".
-}

module ToolShed.Test.Data.List.Splits(
-- * Constants
	results
) where

import			Control.Arrow((***))
import qualified	Data.Tuple
import qualified	ToolShed.Data.List.Splits
import qualified	Test.QuickCheck
import			Test.QuickCheck((==>))

-- | The constant test-results for this data-type.
results :: IO [Test.QuickCheck.Result]
results	= mapM Test.QuickCheck.quickCheckResult [prop_splitsFrom] where
	prop_splitsFrom :: Int -> [Int] -> Test.QuickCheck.Property
	prop_splitsFrom i l	= not (null l) ==> Test.QuickCheck.label "prop_splitsFrom" $ take n (ToolShed.Data.List.Splits.splitsLeftFrom index l) == take n (map (Data.Tuple.swap . (reverse *** reverse)) . ToolShed.Data.List.Splits.splitsRightFrom (length l - index) $ reverse l)	where
		index	= i `mod` length l
		n	= succ index
