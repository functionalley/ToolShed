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

{- |
	* Group equal (though not necessarily adjacent; cf. 'Data.List.groupBy') elements, according to the specified comparator.

	* The groups are returned in ascending order, whilst their elements remain in their original order.
-}
gatherBy :: (Data.Foldable.Foldable f, Ord b) => (a -> b) -> f a -> [[a]]
gatherBy f	= Data.Map.elems . Data.Foldable.foldr (uncurry (Data.Map.insertWith (++)) . (f &&& return {-to List-monad-})) Data.Map.empty

-- | A specific instance of 'gatherBy'.
gather :: (Data.Foldable.Foldable f, Ord a) => f a -> [[a]]
gather	= gatherBy id

-- | Whether the specified collection contains any equal items.
hasDuplicates :: (Data.Foldable.Foldable f, Ord a) => f a -> Bool
hasDuplicates	= any ((> 1) . length) . gather

