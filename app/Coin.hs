module Coin where

import Graphics.Gloss

import System.Random

import Types

drawCoin :: Float -> (Float, Float) -> [Picture]
-- drawCoin :: (p -> m a1) -> (a2, b) -> [Picture]
drawCoin cellSize (x, y) = 
    [translate (x * cellSize) (y * cellSize) 
    $ rectangleSolid cellSize cellSize]
    -- where
    --     positionX = generateCoinPosition
    --     positionY = generateCoinPosition

-- generateCoinPosition :: (Random a, Control.Monad.IO.Class.MonadIO m, Num a) => p -> m a
generateCoinPosition a = randomRIO (0,  31)
