module Main where

import Data.List.Unweave (unweave, unweave3)
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import Data.Version (showVersion)
import Options.Applicative (Parser, ParserInfo)
import qualified Options.Applicative as Opts
import Paths_data_list_unweave (version)

type Options = (Mode, Text)

data Mode = Two | Three

main :: IO ()
main = do
  (mode, delim) <- Opts.execParser parser
  input <- Text.splitOn delim . Text.stripEnd <$> Text.getContents
  let output = case mode of
        Two ->
          let (xs, ys) = unweave input
              xs' = Text.intercalate delim xs
              ys' = Text.intercalate delim ys
           in Text.unlines [xs', ys']
        Three ->
          let (xs, ys, zs) = unweave3 input
              xs' = Text.intercalate delim xs
              ys' = Text.intercalate delim ys
              zs' = Text.intercalate delim zs
           in Text.unlines [xs', ys', zs']
  Text.putStr output

parser :: ParserInfo Options
parser = Opts.info (Opts.helper <*> parseOptions) $ mconcat
  [ Opts.fullDesc
  , Opts.header ("unweave " <> showVersion version)
  , Opts.footer "https://github.com/pnotequalnp/data-list-unweave"
  ]

parseOptions :: Parser Options
parseOptions = (,) <$> parseMode <*> parseDelimiter

parseMode :: Parser Mode
parseMode = Opts.flag Two Three $ mconcat
  [ Opts.short '3'
  , Opts.long "three"
  , Opts.help "Unweave three ways"
  ]

parseDelimiter :: Parser Text
parseDelimiter = Opts.strOption $ mconcat
  [ Opts.short 'd'
  , Opts.long "delimiter"
  , Opts.metavar "DELIMITER"
  , Opts.help "Delimiter to use"
  , Opts.value (Text.pack " ")
  , Opts.showDefault
  ]
