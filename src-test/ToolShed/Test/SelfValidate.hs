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

 [@DESCRIPTION@]	Defines /QuickCheck/-properties "ToolShed.SelfValidate".
-}

module ToolShed.Test.SelfValidate(
-- * Constants
	results,
-- * Types
-- ** Data-types
--	Primes
) where

import qualified	Data.Foldable
import qualified	Data.List
import qualified	Data.Map
import qualified	Data.Set
import qualified	Test.QuickCheck
import			Test.QuickCheck((==>))
import qualified	ToolShed.SelfValidate	as SelfValidate
import			ToolShed.Test.QuickCheck.Arbitrary.Map()
import			ToolShed.Test.QuickCheck.Arbitrary.Set()

-- | A test-type.
newtype Primes	= MkPrimes Int	deriving (Eq, Ord, Show)

instance SelfValidate.SelfValidator Primes	where
	getErrors (MkPrimes i)	= SelfValidate.extractErrors [
		(any ((== 0) . (i `rem`)) [2,3,5],	"Composite; " ++ show i),
		(i < 0,					"Negative; " ++ show i),
		(i `elem` [0, 1],			"Excluded; " ++ show i)
	 ]

instance Test.QuickCheck.Arbitrary Primes	where
	arbitrary	= MkPrimes `fmap` Test.QuickCheck.elements [negate limit .. limit]	where limit = pred $ 7 * 7

-- | The constant test-results for this data-type.
results :: IO [Test.QuickCheck.Result]
results	= sequence [
	Test.QuickCheck.quickCheckResult prop_list,
	Test.QuickCheck.quickCheckResult prop_list',
	Test.QuickCheck.quickCheckResult prop_set,
	Test.QuickCheck.quickCheckResult prop_map
 ] where
		prop_list, prop_list' :: [Primes] -> Test.QuickCheck.Property
		prop_list l	= not (null l) ==> Test.QuickCheck.label "prop_list" $ SelfValidate.getErrors (head l) `Data.List.isPrefixOf` SelfValidate.getErrors l
		prop_list' l	= Test.QuickCheck.label "prop_list'" $ all (
			(`elem` map SelfValidate.getErrors l) . SelfValidate.getErrors
		 ) l

		prop_set :: Data.Set.Set Primes -> Test.QuickCheck.Property
		prop_set s	= Test.QuickCheck.label "prop_set" $ Data.Foldable.all (
			(`Data.Set.isSubsetOf` Data.Set.fromList (SelfValidate.getErrors s)) . Data.Set.fromList . SelfValidate.getErrors
		 ) s

		prop_map :: Data.Map.Map Int Primes -> Test.QuickCheck.Property
		prop_map m	= Test.QuickCheck.label "prop_map" $ Data.Foldable.all (
			(`Data.Set.isSubsetOf` Data.Set.fromList (SelfValidate.getErrors m)) . Data.Set.fromList . SelfValidate.getErrors
		 ) m

