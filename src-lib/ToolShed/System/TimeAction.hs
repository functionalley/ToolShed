{-
	Copyright (C) 2011 Dr. Alistair Ward

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

 [@DESCRIPTION@]	Determines the CPU-time, required to evaluate the specified IO-action.

-}

module ToolShed.System.TimeAction(
-- * Functions
	getCPUSeconds,
	printCPUSeconds
) where

import qualified	System.CPUTime
import qualified	System.IO

-- | Time the specified IO-action, returning the required number of CPU-seconds and the result, as a 'Pair'.
getCPUSeconds :: Fractional seconds => IO result -> IO (seconds, result)
getCPUSeconds action	= do
	startTime	<- System.CPUTime.getCPUTime
	result		<- action
	endTime		<- System.CPUTime.getCPUTime

	return {-to IO-monad-} (fromInteger (endTime - startTime) / 1e12 {-convert from pico-seconds-}, result)

-- | Print the time required by the specified IO-action.
printCPUSeconds :: IO result -> IO result
printCPUSeconds action	= do
	(cpuSeconds, result)	<- getCPUSeconds action

	System.IO.hPutStrLn System.IO.stderr $ "CPU-seconds:\t" ++ show (cpuSeconds :: Double)

	return {-to IO-monad-} result
