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

 [@DESCRIPTION@]	Miscellaneous polymorphic operations on 'Data.Foldable.Foldable' types.
-}

module ToolShed.Data.Foldable(
-- * Functions
	gather,
	gatherBy,
-- ** Predicates
	hasDuplicates
) where

import			Control.Arrow((&&&))
import qualified	Data.Foldable
import qualified	Data.Map
import qualified	Data.Set

{- |
	* Group equal (though not necessarily adjacent; cf. 'Data.List.groupBy') elements, according to the specified comparator.

	* The groups are returned in ascending order, whilst their elements remain in their original order.

	* See 'GHC.Exts.groupWith'.
-}
gatherBy
	:: (Data.Foldable.Foldable foldable, Ord b)
	=> (a -> b)	-- ^ Function to apply before testing for equality.
	-> foldable a	-- ^ The input data.
	-> [[a]]
gatherBy f	= Data.Map.elems . Data.Foldable.foldr (uncurry (Data.Map.insertWith (++)) . (f &&& return {-to List-monad-})) Data.Map.empty

-- | A specific instance of 'gatherBy'.
gather :: (Data.Foldable.Foldable foldable, Ord a) => foldable a -> [[a]]
gather	= gatherBy id

-- | Whether the specified collection contains any equal items.
hasDuplicates :: (Data.Foldable.Foldable foldable, Ord a) => foldable a -> Bool
hasDuplicates	= fst . Data.Foldable.foldr (
	\x (result, s)	-> if result || Data.Set.member x s
		then (True, s)
		else (False, Data.Set.insert x s)
 ) (False, Data.Set.empty)
