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

 [@DESCRIPTION@]	Defines /QuickCheck/-properties "ToolShed.Data.List".
-}

module ToolShed.Test.Data.List(
-- * Constants
	results
) where

import qualified	Data.List
import qualified	ToolShed.Data.List
import qualified	Test.QuickCheck
import			Test.QuickCheck((==>))

-- | The constant test-results for this data-type.
results :: IO [Test.QuickCheck.Result]
results	= sequence [
	Test.QuickCheck.quickCheckResult prop_chunk,
	Test.QuickCheck.quickCheckResult prop_findConvergence,
	Test.QuickCheck.quickCheckResult prop_linearise,
	Test.QuickCheck.quickCheckResult prop_merge,
	Test.QuickCheck.quickCheckResult prop_nub,
	Test.QuickCheck.quickCheckResult prop_permutations,
	Test.QuickCheck.quickCheckResult prop_permutations',
	Test.QuickCheck.quickCheckResult prop_permutationsBy,
	Test.QuickCheck.quickCheckResult prop_permutationsBy'
 ] where
		prop_chunk :: Int -> [Int] -> Test.QuickCheck.Property
		prop_chunk i l		= Test.QuickCheck.label "prop_chunk" $ concat (ToolShed.Data.List.chunk (succ $ abs i) l) == l

		prop_findConvergence :: Int -> Test.QuickCheck.Property
		prop_findConvergence	= Test.QuickCheck.label "prop_findConvergence" . (== 0) . ToolShed.Data.List.findConvergence . iterate (fst . (`quotRem` 2))

		prop_linearise :: [(Int, Int)] -> Test.QuickCheck.Property
		prop_linearise l	= Test.QuickCheck.label "prop_linearise" $ map (\[x, y] -> (x, y)) (ToolShed.Data.List.chunk 2 $ ToolShed.Data.List.linearise l) == l

		prop_merge :: [Int] -> [Int] -> Test.QuickCheck.Property
		prop_merge x y	= Test.QuickCheck.label "prop_merge" $ ToolShed.Data.List.merge (Data.List.sort x) (Data.List.sort y) == Data.List.sort (x ++ y)

		prop_nub :: [Int] -> Test.QuickCheck.Property
		prop_nub x	= Test.QuickCheck.label "prop_nub" $ ToolShed.Data.List.nub' x == Data.List.sort (Data.List.nub x)

		prop_permutations, prop_permutations', prop_permutationsBy :: [[Int]] -> Test.QuickCheck.Property
		prop_permutations l	= not (null l')	==> Test.QuickCheck.label "prop_permutations" $ length (ToolShed.Data.List.permutations l') == product (map length l')	where
			l'	= take 6 $ map (take 6) l	-- Limit the task.

		prop_permutations' l	= not (null l') && all (not . null) l'	==> Test.QuickCheck.label "prop_permutations'" . (== 1) . length . Data.List.nub . map length $ ToolShed.Data.List.permutations l'	where
			l'	= take 7 $ map (take 5) l	-- Limit the task.

		prop_permutationsBy l	= and [not $ null l', all (not . null) l', not $ null permutations]	==> Test.QuickCheck.label "prop_permutationsBy" . (== 1) . length . Data.List.nub $ map (length . Data.List.nub) permutations	where
			l'		= take 8 $ map (take 4) l	-- Limit the task.
			permutations	= ToolShed.Data.List.permutationsBy (/=) l'

		prop_permutationsBy' :: Int -> Test.QuickCheck.Property
		prop_permutationsBy' i	= Test.QuickCheck.label "prop_permutationsBy'" . all ((== range) . Data.List.sort) . ToolShed.Data.List.permutationsBy (/=) $ replicate (succ i') range	where
			i'	= succ $ mod i 7
			range	= [0 .. i']

