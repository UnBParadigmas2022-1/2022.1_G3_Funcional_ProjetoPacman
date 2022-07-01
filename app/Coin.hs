module Coin where

import Graphics.Gloss

import System.Random ( randomRs, mkStdGen )

import Types

drawCoin :: Float -> (Float, Float) -> [Picture]
-- drawCoin :: (p -> m a1) -> (a2, b) -> [Picture]
drawCoin cellSize (x, y) = 
    [translate (x * cellSize) (y * cellSize)
    $ rectangleSolid cellSize cellSize]
    -- where
    --     positionX = generateCoinPosition
    --     positionY = generateCoinPosition cellSize


-- rndPoints1 :: a -> [Int]
-- generateCoinPosition _ = head x
--   where
--     x = randomRs (1, 31) mkStdGen (1)
