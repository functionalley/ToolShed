{-
	Copyright (C) 2016 Dr. Alistair Ward

	This file is part of ToolShed.

	ToolShed is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	ToolShed is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with ToolShed.  If not, see <http://www.gnu.org/licenses/>.
-}
{- |
 [@AUTHOR@]	Dr. Alistair Ward

 [@DESCRIPTION@]

	* Static tests.

	* <http://www.census.gov/srd/papers/pdf/rrs2006-02.pdf>
-}

module ToolShed.Test.HUnit.Data.List(
-- * Constants
	testCases
-- * Functions
--	approxDistance
) where

import qualified	Test.HUnit
import			Test.HUnit((~:),(~?=))
import qualified	ToolShed.Data.List	as Data.List

approxDistance :: (String, String) -> Double
approxDistance pair	= (/ fromIntegral precision) . fromInteger . round $ (fromIntegral precision * Data.List.measureJaroDistance pair :: Rational)	where
	precision :: Int
	precision	= 1000

-- | Check the sanity of the implementation, by validating a list of static test-cases.
testCases :: Test.HUnit.Test
testCases	= Test.HUnit.test [
	"ToolShed.Data.List.measureJaroDistance 1 failed." ~: Data.List.measureJaroDistance ("DIXON", "DICKSONX") ~?= (4 / 5 + 4 / 8 + 1 :: Rational) / 3,
	"ToolShed.Data.List.measureJaroDistance 2 failed." ~: Data.List.measureJaroDistance ("JELLYFISH", "SMELLYFISH") ~?= (8 / 9 + 8 / 10 + 1 :: Rational) / 3,
	"ToolShed.Data.List.measureJaroDistance 3 failed." ~: approxDistance ("SHACKLEFORD", "SHACKELFORD") ~?= 0.970,
	"ToolShed.Data.List.measureJaroDistance 4 failed." ~: approxDistance ("DUNNINGHAM", "CUNNIGHAM") ~?= 0.896,
	"ToolShed.Data.List.measureJaroDistance 5 failed." ~: approxDistance ("NICHLESON", "NICHULSON") ~?= 0.926,
	"ToolShed.Data.List.measureJaroDistance 6 failed." ~: approxDistance ("JONES", "JOHNSON") ~?= 0.790,
	"ToolShed.Data.List.measureJaroDistance 7 failed." ~: approxDistance ("MASSEY", "MASSIE") ~?= 0.889,
	"ToolShed.Data.List.measureJaroDistance 8 failed." ~: approxDistance ("ABROMS", "ABRAMS") ~?= 0.889,
	"ToolShed.Data.List.measureJaroDistance 9 failed." ~: Data.List.measureJaroDistance ("HARDIN", "MARTINEZ") ~?= (4 / 6 + 4 / 8 + 1 :: Rational) / 3,	-- CAVEAT: cited paper says this value should be zero ?!
	"ToolShed.Data.List.measureJaroDistance 10 failed." ~: Data.List.measureJaroDistance ("ITMAN", "SMITH") ~?= (1 / 5 + 1 / 5 + 1 :: Rational) / 3,	-- CAVEAT: cited paper says this value should be zero ?!
	"ToolShed.Data.List.measureJaroDistance 11 failed." ~: approxDistance ("JERALDINE", "GERALDINE") ~?= 0.926,
	"ToolShed.Data.List.measureJaroDistance 12 failed." ~: approxDistance ("MARHTA", "MARTHA") ~?= 0.944,
	"ToolShed.Data.List.measureJaroDistance 13 failed." ~: approxDistance ("MICHELLE", "MICHAEL") ~?= 0.869,
	"ToolShed.Data.List.measureJaroDistance 14 failed." ~: approxDistance ("JULIES", "JULIUS") ~?= 0.889,
	"ToolShed.Data.List.measureJaroDistance 15 failed." ~: approxDistance ("TANYA", "TONYA") ~?= 0.867,
	"ToolShed.Data.List.measureJaroDistance 16 failed." ~: approxDistance ("DWAYNE", "DUANE") ~?= 0.822,
	"ToolShed.Data.List.measureJaroDistance 17 failed." ~: approxDistance ("SEAN", "SUSAN") ~?= 0.783,
	"ToolShed.Data.List.measureJaroDistance 18 failed." ~: approxDistance ("JON", "JOHN") ~?= 0.917,
	"ToolShed.Data.List.measureJaroDistance 19 failed." ~: Data.List.measureJaroDistance ("JON", "JAN") ~?= (2 / 3 + 2 / 3 + 1 :: Rational) / 3	-- CAVEAT: cited paper says this value should be zero ?!
 ]
