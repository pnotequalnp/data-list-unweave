module Main (main) where

import Data.List.Unweave (unweave, unweave3)
import Test.Tasty (TestTree, defaultMain, testGroup)
import Test.Tasty.HUnit (testCase, (@?=))

main :: IO ()
main = defaultMain (testGroup "Data.List.Unweave" [unweaveTests, unweave3Tests])

unweaveTests :: TestTree
unweaveTests =
  testGroup
    "unweave"
    [ testCase "[]" $
        unweave ([] :: [()]) @?= ([], []),
      testCase "[()]" $
        unweave [()] @?= ([()], []),
      testCase "[1..10]" $
        unweave [1 .. 10 :: Int] @?= ([1, 3, 5, 7, 9], [2, 4, 6, 8, 10])
    ]

unweave3Tests :: TestTree
unweave3Tests =
  testGroup
    "unweave3"
    [ testCase "[]" $
        unweave3 ([] :: [()]) @?= ([], [], []),
      testCase "[()]" $
        unweave3 [()] @?= ([()], [], []),
      testCase "[(), ()]" $
        unweave3 [(), ()] @?= ([()], [()], []),
      testCase "[1..10]" $
        unweave3 [1 .. 10 :: Int] @?= ([1, 4, 7, 10], [2, 5, 8], [3, 6, 9])
    ]
