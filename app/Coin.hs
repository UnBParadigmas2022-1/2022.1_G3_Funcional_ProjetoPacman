module Coin where

import Graphics.Gloss

import System.Random
import System.IO.Unsafe

import Map

import Types
import GHC.Float (int2Float)


drawCoin :: Float -> Assets -> Picture
drawCoin cellSize [_, _, _, _, _, coin] =
    translate newX newY coin
    where
        (x, y) = (3, -1)
        newX = x * cellSize
        newY = y * cellSize


generateRandom :: Point -> Point
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
