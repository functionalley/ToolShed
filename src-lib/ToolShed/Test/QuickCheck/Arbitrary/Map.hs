{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# LANGUAGE CPP #-}
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

 [@DESCRIPTION@]	Implements 'Test.QuickCheck.Arbitrary' for 'Data.Map.Map'; which was subsequently implemented in "QuickCheck-2.8.2".

 [@EXAMPLE@]	@Test.QuickCheck.sample (Test.QuickCheck.arbitrary :: Test.QuickCheck.Gen.Gen (Data.Map.Map Char Int))@
-}

module ToolShed.Test.QuickCheck.Arbitrary.Map() where

#if !MIN_VERSION_QuickCheck(2,8,2)
import qualified	Data.Map
import qualified	Test.QuickCheck

instance (Ord k, Test.QuickCheck.Arbitrary k, Test.QuickCheck.Arbitrary v) => Test.QuickCheck.Arbitrary (Data.Map.Map k v)	where
	arbitrary	= Data.Map.fromList `fmap` Test.QuickCheck.arbitrary {-[(k, v)]-}
#endif

