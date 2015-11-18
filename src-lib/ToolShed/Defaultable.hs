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

 [@DESCRIPTION@]	A simple interface which data-types with a default-value can implement.
-}

module ToolShed.Defaultable(
-- * Type-classes
	Defaultable(..)
) where

-- | An interface to which data which have a default-value can adhere.
class Defaultable a	where
	defaultValue	:: a	-- ^ The default value of the data-type.

instance (Defaultable a, Defaultable b) => Defaultable (a, b)	where
	defaultValue	= (defaultValue, defaultValue)

instance (Defaultable a, Defaultable b, Defaultable c) => Defaultable (a, b, c)	where
	defaultValue	= (defaultValue, defaultValue, defaultValue)
