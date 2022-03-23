module Main (main) where

import Criterion.Main (Benchmark, bench, bgroup, defaultMain, nf)
import Data.List.Unweave (unweave, unweave3)

main :: IO ()
main = defaultMain [unweaveBench, unweave3Bench]

unweaveBench :: Benchmark
unweaveBench =
  bgroup
    "unweave"
    [ bench "[]" $ nf unweave ([] :: [Int]),
      bench "[1..1_000]" $ nf unweave [1 .. 1000 :: Int],
      bench "[1..1_000_000]" $ nf unweave [1 .. 1000000 :: Int]
    ]

unweave3Bench :: Benchmark
unweave3Bench =
  bgroup
    "unweave3"
    [ bench "[]" $ nf unweave3 ([] :: [Int]),
      bench "[1..1_000]" $ nf unweave3 [1 .. 1000 :: Int],
      bench "[1..1_000_000]" $ nf unweave3 [1 .. 1000000 :: Int]
    ]
