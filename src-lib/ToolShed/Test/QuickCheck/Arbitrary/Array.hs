{-# OPTIONS_GHC -fno-warn-orphans #-}
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

 [@DESCRIPTION@]

	Implements 'Test.QuickCheck.Arbitrary' for 'Data.Array.IArray.Array',
	where the array-index is required to be a /bounded enumerable/ type.

 [@EXAMPLE@]	@Test.QuickCheck.sample (Test.QuickCheck.arbitrary :: Test.QuickCheck.Gen.Gen (Data.Array.IArray.Array Data.Int.Int8 Int))@
-}

module ToolShed.Test.QuickCheck.Arbitrary.Array() where

import qualified	Data.Array.IArray
import qualified	Test.QuickCheck

instance (Bounded i, Data.Array.IArray.Ix i, Enum i, Test.QuickCheck.Arbitrary e) => Test.QuickCheck.Arbitrary (Data.Array.IArray.Array i e)	where
	arbitrary	= (Data.Array.IArray.array bounds . zip [minBound .. maxBound]) `fmap` Test.QuickCheck.vector (succ $ fromEnum (snd bounds) - fromEnum (fst bounds))	where
		bounds	= (minBound, maxBound)

