{-
	Copyright (C) 2015 Dr. Alistair Ward

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

 [@DESCRIPTION@]

	* The entry-point to the application's test-suite.
-}

module Main(main) where

import qualified	Control.Monad
import qualified	Test.HUnit
import qualified	System.Exit
import qualified	ToolShed.Test.HUnit.Data.List			as Test.HUnit.Data.List
import qualified	ToolShed.Test.QuickCheck.Data.Foldable		as Test.QuickCheck.Data.Foldable
import qualified	ToolShed.Test.QuickCheck.Data.List		as Test.QuickCheck.Data.List
import qualified	ToolShed.Test.QuickCheck.Data.List.Runlength	as Test.QuickCheck.Data.List.Runlength
import qualified	ToolShed.Test.QuickCheck.Data.List.Splits	as Test.QuickCheck.Data.List.Splits
import qualified	ToolShed.Test.QuickCheck.Data.Quadruple		as Test.QuickCheck.Data.Quadruple
import qualified	ToolShed.Test.QuickCheck.Data.Triple		as Test.QuickCheck.Data.Triple
import qualified	ToolShed.Test.QuickCheck.Result			as Test.QuickCheck.Result
import qualified	ToolShed.Test.QuickCheck.SelfValidate		as Test.QuickCheck.SelfValidate
import qualified	ToolShed.Test.QuickCheck.System.Random		as Test.QuickCheck.System.Random

-- | Entry-point.
main :: IO ()
main	= mapM_ Test.HUnit.runTestTT [
	Test.HUnit.Data.List.testCases
 ] >> mapM_ (
	(`Control.Monad.unless` System.Exit.exitFailure) . all Test.QuickCheck.Result.isSuccessful =<<
 ) [
	Test.QuickCheck.Data.Foldable.results,
	Test.QuickCheck.Data.List.results,
	Test.QuickCheck.Data.List.Runlength.results,
	Test.QuickCheck.Data.List.Splits.results,
	Test.QuickCheck.Data.Quadruple.results,
	Test.QuickCheck.Data.Triple.results,
	Test.QuickCheck.SelfValidate.results,
	Test.QuickCheck.System.Random.results
 ]

