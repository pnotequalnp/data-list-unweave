-- |
-- Module      :  Data.List.Unweave
-- Copyright   :  Kevin Mullins 2022
-- License     :  ISC
-- Maintainer  :  kevin@pnotequalnp.com
-- Stability   :  stable
-- Portability :  portable
--
-- = Data.List.Unweave
-- Functions for unweaving lists.
module Data.List.Unweave
  ( unweave,
    unweave3,
  )
where

-- | /O(n)/. Unweave a list, such that the two components interleaved are the original list.
--
-- Example:
--
-- >>> unweave [1..10]
-- ([1,3,5,7,9],[2,4,6,8,10])
unweave :: [a] -> ([a], [a])
unweave [] = ([], [])
unweave l@[_] = (l, [])
unweave (y : z : xs) =
  let (ys, zs) = unweave xs
   in (y : ys, z : zs)

-- | /O(n)/. Unweave a list, such that the three components interleaved are the original list.
--
-- Example:
--
-- >>> unweave3 [1..10]
-- ([1,4,7,10],[2,5,8],[3,6,9])
unweave3 :: [a] -> ([a], [a], [a])
unweave3 [] = ([], [], [])
unweave3 l@[_] = (l, [], [])
unweave3 [x, y] = ([x], [y], [])
unweave3 (x : y : z : ws) =
  let (xs, ys, zs) = unweave3 ws
   in (x : xs, y : ys, z : zs)
