module Coin where

import Graphics.Gloss

import System.Random
import System.IO.Unsafe

import Map

import Types
import GHC.Float (int2Float)


drawCoin :: Float -> Assets -> Coin -> Picture
drawCoin cellSize [_, _, _, _, _, coin] (x, y) =
    translate newX newY coin
    where
        newX = x * cellSize
        newY = y * cellSize


generateRandom :: Float -> (Int, Int)
generateRandom dt = 
    (unsafePerformIO (randomRIO (0, round Map.mapaWidth)),  
    unsafePerformIO (randomRIO (0, round Map.mapaHeight)))


updateCoin :: Float -> Coin
updateCoin dt
    | isCellFree random = random
    | otherwise = updateCoin (dt+1)
    where
        (x, y) = generateRandom dt
        random = (int2Float x, -(int2Float y))
