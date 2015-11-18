
{-
	Copyright (C) 2011-2015 Dr. Alistair Ward

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

 [@DESCRIPTION@]	File-operations.
-}

module ToolShed.System.File(
-- * Types
-- ** Type-synonyms
	SearchPath,
	LocatedData,
-- * Functions
	locate,
	getFile,
	fromFile,
-- ** Accessors
	getFilePath,
	getData
) where

import qualified	Control.Exception
import qualified	Control.Monad
import qualified	Data.List
import qualified	System.Directory
import qualified	System.FilePath
import			System.FilePath((</>))
import qualified	System.IO.Error

-- | The ordered sequence of directories, searched for a file.
type SearchPath	= [System.FilePath.FilePath]

{- |
	* When supplied with an /absolute/ file-path, the /search-path/ is ignored and an exception is thrown if either the file-path is invalid or the file doesn't exist.

	* If the specified file-name is /relative/, all matching instances on the specified /search-path/ are returned.

	* CAVEAT: doesn't perform file-globbing.
-}
locate :: System.FilePath.FilePath -> SearchPath -> IO [System.FilePath.FilePath]
locate fileName searchPath
	| System.FilePath.isRelative fileName'		= Control.Monad.filterM System.Directory.doesFileExist . filter System.FilePath.isValid . Data.List.nubBy System.FilePath.equalFilePath $ map (System.FilePath.normalise . (</> fileName')) searchPath
	| not $ System.FilePath.isValid fileName'	= Control.Exception.throwIO . System.IO.Error.userError $ "Invalid filename; " ++ fileName'
	| otherwise					= do
		fileExists	<- System.Directory.doesFileExist fileName'

		if not fileExists
			then Control.Exception.throwIO . System.IO.Error.mkIOError System.IO.Error.doesNotExistErrorType "No such file" Nothing $ Just fileName'
			else return {-to IO-monad-} [fileName']
	where
		fileName'	= System.FilePath.normalise fileName

-- | A file-path, and the contents read from it.
type LocatedData a	= (System.FilePath.FilePath, a)

-- | Accessor.
getFilePath :: LocatedData a -> System.FilePath.FilePath
getFilePath	= fst

-- | Accessor.
getData :: LocatedData a -> a
getData	= snd

{- |
	Traverse the /search-path/, looking for matching instances of the specified file-name,
	and either throw an exception, or return a pair composed from the path to the first matching file, together with its contents.
-}
getFile :: System.FilePath.FilePath -> SearchPath -> IO (LocatedData String)
getFile fileName directories	= do
	filePaths	<- locate fileName directories

	if null filePaths
		then Control.Exception.throwIO . System.IO.Error.mkIOError System.IO.Error.doesNotExistErrorType ("Can't find in " ++ show directories) Nothing $ Just fileName
		else {-located-} let
			filePath	= head filePaths	-- Discard any subsequent paths.
		in (,) filePath `fmap` readFile filePath

{- |
	* Returns the polymorphic data, read from the first matching file on the /search-path/, along with the path from which it was read.

	* Returns an error on failure to parse the contents of the first matching file found on the /search-path/.
-}
fromFile :: Read a => System.FilePath.FilePath -> SearchPath -> IO (LocatedData a)
fromFile fileName directories	= do
	(filePath, fileContents)	<- getFile fileName directories

	case reads fileContents of
		[(x, _)]	-> return {-to IO-monad-} (filePath, x)	-- CAVEAT: discards any unconsumed text.
		_		-> error . showString "ToolShed.System.File.fromFile:\tfailed to parse file=" $ shows filePath "."

