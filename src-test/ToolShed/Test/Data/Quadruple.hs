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

 [@DESCRIPTION@]	Defines /QuickCheck/-properties "ToolShed.Data.Quadruple".
-}

module ToolShed.Test.Data.Quadruple(
-- * Constants
	results
) where

import qualified	Test.QuickCheck
import qualified	ToolShed.Data.Quadruple

-- | The constant test-results for this data-type.
results :: IO [Test.QuickCheck.Result]
results	= mapM Test.QuickCheck.quickCheckResult [prop_accessors]	where
	prop_accessors :: (Int, Char, Bool, Float) -> Test.QuickCheck.Property
	prop_accessors quadruple	= Test.QuickCheck.label "prop_accessors" $ (f ToolShed.Data.Quadruple.getFirst quadruple, f ToolShed.Data.Quadruple.getSecond quadruple, f ToolShed.Data.Quadruple.getThird quadruple, ToolShed.Data.Quadruple.getFourth quadruple) == quadruple	where
		f	= ToolShed.Data.Quadruple.uncurry4 . ToolShed.Data.Quadruple.curry4
