module Coin where

import Graphics.Gloss

import System.Random
import System.IO.Unsafe

import Map

import Types
import GHC.Float (int2Float)


drawCoin :: Float -> Assets -> [Picture]
drawCoin cellSize [_, _, _, _, coin] =
    [translate positionX positionY $ coin]
    where
        (newX, newY) = (10, 10)
        positionX = newX * cellSize
        positionY = newY * cellSize


generateRandom :: Point -> (Float, Float)
generateRandom (x, y) = 
    (unsafePerformIO (getStdRandom (randomR (0, 28))),  
    unsafePerformIO (getStdRandom (randomR (0, 31))))


-- nextPosition :: Point
-- nextPosition
--     | cellFree = random
--     | otherwise = nextPosition
--     where
--         (x, y) = generateRandom (0, 31)
--         random = (int2Float (round x), int2Float(round y))
--         cellFree = isCellFree random
