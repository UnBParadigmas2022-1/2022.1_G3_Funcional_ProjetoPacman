module Player where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Map
import Types (CellSize, Player, Game)


drawPlayer :: CellSize -> Player -> [Picture]
drawPlayer cellSize ((x, y), (_, _)) =
    (translate (cellSize*x) (-cellSize*y) $ color white $ rectangleSolid cellSize cellSize) : []

updatePlayer :: Game -> Game
updatePlayer game = game

inputPlayer :: Event -> Game -> Game
inputPlayer _ game = game
