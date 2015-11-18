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

import			Control.Arrow((***))
import qualified	Control.Monad
import qualified	System.Exit
import qualified	ToolShed.Test.Data.Foldable		as Test.Data.Foldable
import qualified	ToolShed.Test.Data.List			as Test.Data.List
import qualified	ToolShed.Test.Data.List.Runlength	as Test.Data.List.Runlength
import qualified	ToolShed.Test.Data.List.Splits		as Test.Data.List.Splits
import qualified	ToolShed.Test.Data.Quadruple		as Test.Data.Quadruple
import qualified	ToolShed.Test.Data.Triple		as Test.Data.Triple
import qualified	ToolShed.Test.QuickCheck.Result		as Test.QuickCheck.Result
import qualified	ToolShed.Test.SelfValidate		as Test.SelfValidate
import qualified	ToolShed.Test.System.Random		as Test.System.Random

-- | Entry-point.
main :: IO ()
main	= mapM_ (
	snd {-exit-status-} . (
		putStrLn . (++ ":") *** (
			>>= (`Control.Monad.unless` System.Exit.exitFailure) . all Test.QuickCheck.Result.isSuccessful
		)
	)
 ) [
	("Data.Foldable",	Test.Data.Foldable.results),
	("Data.List",		Test.Data.List.results),
	("Data.List.Runlength",	Test.Data.List.Runlength.results),
	("Data.List.Splits",	Test.Data.List.Splits.results),
	("Data.Quadruple",	Test.Data.Quadruple.results),
	("Data.Triple",		Test.Data.Triple.results),
	("SelfValidate",	Test.SelfValidate.results),
	("System.Random",	Test.System.Random.results)
 ]

