module Player where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Map
import Types (CellSize, Player, Game)


drawPlayer :: CellSize -> Player -> [Picture]
drawPlayer cellSize ((x, y), (_, _)) =
    (translate (cellSize*x) (-cellSize*y) $ color white $ rectangleSolid cellSize cellSize) : []

updatePlayer :: Game -> Game
updatePlayer (cellSize, width, mapa, assets, ((x, y), (sx, sy))) =
    (cellSize, width, mapa, assets, ((x+sx, y+sy), (sx, sy)))

inputPlayer :: Event -> Game -> Game
inputPlayer (EventKey (SpecialKey KeyUp) Down _ _) game = movePlayer (0, -1) game
inputPlayer (EventKey (SpecialKey KeyDown) Down _ _) game = movePlayer (0, 1) game
inputPlayer (EventKey (SpecialKey KeyLeft) Down _ _) game = movePlayer (-1, 0) game
inputPlayer (EventKey (SpecialKey KeyRight) Down _ _) game = movePlayer (1, 0) game
inputPlayer _ game = game

movePlayer :: Point -> Game -> Game
movePlayer (sx, sy) (cellSize, width, mapa, assets, ((x, y), (_, _))) =
    (cellSize, width, mapa, assets, ((x, y), (sx, sy)))
