{-
	Copyright (C) 2013-2015 Dr. Alistair Ward

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

 [@DESCRIPTION@]	Defines /QuickCheck/-properties "ToolShed.System.Random".
-}

module ToolShed.Test.System.Random(
-- * Constants
	results,
-- * Functions
--	getMean,
--	getStandardDeviation
) where

import qualified	Control.Arrow
import			Control.Arrow((&&&),(***))
import qualified	Data.Foldable
import qualified	Data.List
import qualified	Data.Map
import qualified	System.Random
import qualified	Test.QuickCheck
import qualified	ToolShed.System.Random

-- | Determines the /mean/ of the specified numbers
getMean :: (Data.Foldable.Foldable f, Real r, Fractional result) => f r -> result
getMean	= uncurry (/) . (realToFrac *** fromIntegral) . Data.Foldable.foldr (\i -> (+ i) *** succ) (0, 0 :: Int)

-- | Find the standard-deviation of the specified list.
getStandardDeviation :: (Data.Foldable.Foldable f, Functor f, Real r) => f r -> Double
getStandardDeviation x	= sqrt . getMean $ fmap ((^ (2 :: Int)) . (+ negate (getMean x :: Rational)) . toRational) x

-- | The constant test-results for this data-type.
results :: IO [Test.QuickCheck.Result]
results	= sequence [
	Test.QuickCheck.quickCheckResult prop_shuffle,
	Test.QuickCheck.quickCheckResult prop_shuffleDistribution
 ] where
		prop_shuffle :: Int -> Int -> Test.QuickCheck.Property
		prop_shuffle seed l	= Test.QuickCheck.label "prop_shuffle" . (== testList) . Data.List.sort $ ToolShed.System.Random.shuffle (System.Random.mkStdGen seed) testList	where
			testList	= [0 .. l `mod` 10000]

		prop_shuffleDistribution :: Int -> Test.QuickCheck.Property
		prop_shuffleDistribution	= Test.QuickCheck.label "prop_shuffleDistribution" . all (
			uncurry (&&) . (
				(
					< recip 20 {-empirically-}	-- The ideal value for a uniform distribution, would be zero.
				) . (
					/ getStandardDeviation (populationSize : replicate (pred $ length testList) 0)	-- Normalise wrt the worst-case; which occurs when this column contains the same letter, for each test-case in the population.
				) . getStandardDeviation &&& (
					== populationSize	-- Confirm the size of the test-data.
				) . Data.Foldable.sum
			)
		 ) . map (
			foldr (
				uncurry $ Data.Map.insertWith (+)
			) (
				Data.Map.fromList . zip testList $ repeat (0 :: Int)	-- Initial value.
			) . (`zip` repeat 1)	-- Count the instances of each letter in this column, which for a uniform distribution, should be approximately the same.
		 ) . Data.List.transpose {-examine the columns-} . take populationSize . map fst {-shuffled digits-} . tail {-drop initial value-} . iterate (
			Control.Arrow.first (`ToolShed.System.Random.shuffle` testList) . System.Random.split . snd
		 ) . (,) undefined . System.Random.mkStdGen	where
			testList :: String
			testList	= ['a' .. 'z']

			populationSize :: Int
			populationSize	= 1000

