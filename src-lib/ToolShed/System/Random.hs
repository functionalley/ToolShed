
{-
	Copyright (C) 2011 Dr. Alistair Ward

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

 [@DESCRIPTION@]	Utilities related to random-numbers.
-}

module ToolShed.System.Random(
-- * Functions
	randomGens,
	shuffle,
	generateSelection,
	generateSelectionFromBounded,
	select
) where

import qualified	Control.Arrow
import qualified	Data.Sequence
import			Data.Sequence((><), ViewL((:<)))
import qualified	System.Random

-- | Constructs an infinite list of independent random-generators.
randomGens :: System.Random.RandomGen randomGen => randomGen -> [randomGen]
randomGens	= uncurry (:) . Control.Arrow.second randomGens {-recurse-} . System.Random.split

{- |
	* Shuffles the specified finite list, using the /Fisher-Yates/ algorithm; <http://en.wikipedia.org/wiki/Fisher-Yates_shuffle>.

	* The resulting list has the same length and constituents as the original; only the order has changed.

	* The input list is traversed, but the items aren't evaluated.
-}
shuffle :: System.Random.RandomGen randomGen => randomGen -> [a] -> [a]
shuffle _ []		= []		-- Not strictly necessary.
shuffle _ singleton@[_]	= singleton	-- Not strictly necessary.
shuffle randomGen l	= slave randomGen s (pred $ Data.Sequence.length s)	where
	s	= Data.Sequence.fromList l

	slave randomGen' s' maxIndex
		| maxIndex < 0	= []
		| otherwise	= selection : slave randomGen'' (first >< remainder) (pred maxIndex) {-recurse-}
		where
			(randomIndex, randomGen'')	= System.Random.randomR (0, maxIndex) randomGen'
			(first, selection :< remainder)	= Control.Arrow.second Data.Sequence.viewl $ Data.Sequence.splitAt randomIndex s'

{- |
	* Generate an infinite list of items, each independently randomly selected from the specified finite list.

	* CAVEAT: because the selections are made non-destructively, duplicates may be returned; cf. 'shuffle'.
-}
generateSelection :: System.Random.RandomGen randomGen => randomGen -> [a] -> [a]
generateSelection _ []		= error "ToolShed.System.Random.generateSelection:\tnull list"
generateSelection _ [x]		= repeat x	-- Not strictly necessary, but more efficient.
generateSelection randomGen l	= map (l !!) $ System.Random.randomRs (0, pred $ length l) randomGen

-- | Return a randomly selected element from the specified list.
select :: System.Random.RandomGen randomGen => randomGen -> [a] -> a
select randomGen	= head . generateSelection randomGen

{- |
	* Generate an infinite list of data, each independently selected random instances of the specified /bounded/ type.

	* E.g. @ (generateSelectionFromBounded `fmap` System.Random.getStdGen) :: IO [Bool] @.
-}
generateSelectionFromBounded :: (System.Random.RandomGen randomGen, Bounded a, System.Random.Random a) => randomGen -> [a]
generateSelectionFromBounded	= System.Random.randomRs (minBound, maxBound)

