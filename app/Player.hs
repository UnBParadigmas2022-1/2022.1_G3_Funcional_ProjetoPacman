module Player where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Map
import Types (Assets, CellSize, Player, Game)


drawPlayer :: Assets -> CellSize -> Player -> Picture
drawPlayer [_, _, _, _, player, _, _] cellSize ((x, y), (_, _)) =
    translate (cellSize*x) (-cellSize*y) $ player

updatePlayer :: Player -> Player
updatePlayer ((x, y), (sx, sy))
    | Map.isTunnel (x+sx, y+sy)     = ((jumpPlayer ((x, y), (sx, sy))))
    | Map.isWallCell (x+sx, y+sy)   = (((x, y), (0, 0)))
    | otherwise                     = (((x+sx, y+sy), (sx, sy)))

jumpPlayer :: Player -> Player
jumpPlayer ((x, y), (sx, sy))
    | sx > 0    = ((0, y), (sx, sy))
    | sx < 0    = ((Map.mapaWidth-1, y), (sx, sy))
    | otherwise = ((x, y), (sx, sy))

inputPlayer :: Event -> Player -> Player
inputPlayer (EventKey (SpecialKey KeyUp) Down _ _) player = movePlayer (0, -1) player
inputPlayer (EventKey (SpecialKey KeyDown) Down _ _) player = movePlayer (0, 1) player
inputPlayer (EventKey (SpecialKey KeyLeft) Down _ _) player = movePlayer (-1, 0) player
inputPlayer (EventKey (SpecialKey KeyRight) Down _ _) player = movePlayer (1, 0) player
inputPlayer _ player = player

movePlayer :: Point -> Player -> Player
movePlayer (nsx, nsy) ((x, y), (sx, sy))
    | Map.isWallCell (x+nsx, y+nsy) = ((x, y), (sx, sy))
    | otherwise = ((x, y), (nsx, nsy))

hasCollision :: Player -> [Point] -> Bool
hasCollision (posPlayer, _) points = any (\(x, y) -> posPlayer == (x, abs y)) points
