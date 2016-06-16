{-
	Copyright (C) 2016 Dr. Alistair Ward

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

 [@DESCRIPTION@]	Miscellaneous String-orientated functions.
-}

module ToolShed.Data.String(
-- * Functions
	deTab
) where

-- | Replaces any embedded tab-characters with the appropriate number of spaces.
deTab
	:: Int	-- ^ Tab-length.
	-> String
	-> String
deTab tabLength
	| tabLength < 0		= error . showString "ToolShed.Data.String.deTab:\ttab-length=" $ shows tabLength " must be negative."
	| tabLength == 0	= filter (/= '\t')
	| otherwise		= slave 0
	where
		slave :: Int -> String -> String
		slave _ []	= []	-- Terminate.
		slave i (c : s)	= case c of
			'\t'	-> replicate (tabLength - mod i tabLength) ' ' ++ slave 0 s
			'\r'	-> c : slave 0 s
			'\n'	-> c : slave 0 s
			_	-> c : slave (succ i) s

