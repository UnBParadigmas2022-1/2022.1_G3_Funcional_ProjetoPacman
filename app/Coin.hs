module Coin where

import System.Random
import Graphics.Gloss
import GHC.Float (int2Float)

import Map
import Types


drawCoin :: Float -> Assets -> Coin -> Picture
drawCoin cellSize [_, _, _, _, _, _, coin, _, _] ((x, y), _) =
    translate newX newY coin
    where
        newX = x * cellSize
        newY = y * cellSize

coinPrice :: Bool -> Int
coinPrice True = 10
coinPrice False = 0

generateRandom :: StdGen -> (Int, Int) -> (Int, StdGen)
generateRandom seed range = uniformR range seed

updateCoin :: Coin -> Coin
updateCoin (pos, seed)
    | isCellFree random = (random, ySeed)
    | otherwise = updateCoin (pos, ySeed)
    where
        (x, xSeed) = generateRandom seed (0 :: Int, round (Map.mapaWidth-1))
        (y, ySeed) = generateRandom xSeed (0 :: Int, round (Map.mapaHeight-1))
        random = (int2Float x, -(int2Float y))
