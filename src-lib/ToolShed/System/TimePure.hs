{-
	Copyright (C) 2010 Dr. Alistair Ward

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

 [@DESCRIPTION@]	Determines the CPU-time, required to evaluate the specified pure expression.

-}

module ToolShed.System.TimePure(
-- * Functions
	getCPUSeconds,
	printCPUSeconds
) where

import qualified	Control.DeepSeq
import qualified	System.CPUTime
import qualified	System.IO

{- |
	* Time the specified pure expression, returning the required number of CPU-seconds and the result, as a 'Pair'.

	* CAVEAT: as a side-effect, the expression is /deep/ evaluated.
-}
getCPUSeconds :: (Fractional seconds, Control.DeepSeq.NFData expression)
	=> expression			-- ^ Arbitrary polymorphic expression.
	-> IO (seconds, expression)	-- ^ The original expression, tagged with the CPU-seconds taken.
getCPUSeconds expression	= do
	start	<- System.CPUTime.getCPUTime
	end	<- expression `Control.DeepSeq.deepseq` System.CPUTime.getCPUTime

	return {-to IO-monad-} (fromInteger (end - start) / 1e12 {-convert from pico-seconds-}, expression)

{- |
	* Print the time required by the specified pure expression.

	* CAVEAT: as a side-effect, the expression is /deep/ evaluated.
-}
printCPUSeconds :: Control.DeepSeq.NFData expression => expression -> IO expression
printCPUSeconds expression	= do
	(cpuSeconds, result)	<- getCPUSeconds expression

	System.IO.hPutStrLn System.IO.stderr $ "CPU-seconds:\t" ++ show (cpuSeconds :: Double)

	return {-to IO-monad-} result

