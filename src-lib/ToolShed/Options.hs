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

 [@DESCRIPTION@]	Defines a standard interface to which various options-related data can conform.
-}

module ToolShed.Options(
-- * Type-classes
	Options(..)
) where

import qualified	ToolShed.Defaultable

-- | Similar to the class 'Text.Regex.Base.RegexLike.RegexOptions'.
class ToolShed.Defaultable.Defaultable a => Options a	where
	blankValue	:: a	-- ^ The /undefined/ state of the data-type, which may be literal, but could alternatively be a logical starting value.
