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

 [@DESCRIPTION@]	Defines /QuickCheck/-properties "ToolShed.Data.Triple".
-}

module ToolShed.Test.Data.Triple(
-- * Constants
	results
) where

import qualified	Test.QuickCheck
import qualified	ToolShed.Data.Triple

-- | The constant test-results for this data-type.
results :: IO [Test.QuickCheck.Result]
results	= mapM Test.QuickCheck.quickCheckResult [prop_accessors]	where
	prop_accessors :: (Int, Char, Bool) -> Test.QuickCheck.Property
	prop_accessors triple	= Test.QuickCheck.label "prop_accessors" $ (f ToolShed.Data.Triple.getFirst triple, f ToolShed.Data.Triple.getSecond triple, f ToolShed.Data.Triple.getThird triple) == triple	where
		f	= ToolShed.Data.Triple.uncurry3 . ToolShed.Data.Triple.curry3

