module Coin where

import Graphics.Gloss

import Types

drawCoin :: Float -> (Float, Float) -> [Picture]
drawCoin cellSize (x, y) =
    [translate (x * cellSize) (y * cellSize) 
    $ rectangleSolid cellSize cellSize]
