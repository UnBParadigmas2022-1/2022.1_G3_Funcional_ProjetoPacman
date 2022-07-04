module Player where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Map
import Types (Assets, CellSize, Player, Game)


drawPlayer :: Assets -> CellSize -> Player -> Picture
drawPlayer [_, _, _, _, player, _, _, _, _] cellSize ((x, y), (sx, sy), angle) =
    translate (cellSize*x) (-cellSize*y) $ scale 1 (mirror) $ rotate angle player
    where
        mirror = fromInteger $ ceiling $ (sin angle) + (cos angle)

anglePlayer :: Point -> Float -> Float
anglePlayer (sx, sy) angle
    | sx < 0    = 180
    | sx > 0    = 0
    | sy > 0    = 90
    | sy < 0    = 270
    | otherwise = angle

updatePlayer :: Player -> Player
updatePlayer ((x, y), (sx, sy), angle)
    | Map.isTunnel (x+sx, y+sy)     = (jumpPlayer ((x, y), (sx, sy), anglePlayer (sx, sy) angle))
    | Map.isWallCell (x+sx, y+sy)   = ((x, y), (0, 0), anglePlayer (sx, sy) angle)
    | otherwise                     = ((x+sx, y+sy), (sx, sy), anglePlayer (sx, sy) angle)

jumpPlayer :: Player -> Player
jumpPlayer ((x, y), (sx, sy), angle)
    | sx > 0    = ((0, y), (sx, sy), angle)
    | sx < 0    = ((Map.mapaWidth-1, y), (sx, sy), angle)
    | otherwise = ((x, y), (sx, sy), angle)

inputPlayer :: Event -> Player -> Player
inputPlayer (EventKey (SpecialKey KeyUp) Down _ _) player = movePlayer (0, -1) player
inputPlayer (EventKey (SpecialKey KeyDown) Down _ _) player = movePlayer (0, 1) player
inputPlayer (EventKey (SpecialKey KeyLeft) Down _ _) player = movePlayer (-1, 0) player
inputPlayer (EventKey (SpecialKey KeyRight) Down _ _) player = movePlayer (1, 0) player
inputPlayer _ player = player

movePlayer :: Point -> Player -> Player
movePlayer (nsx, nsy) ((x, y), (sx, sy), angle)
    | Map.isWallCell (x+nsx, y+nsy) = ((x, y), (sx, sy), angle)
    | otherwise = ((x, y), (nsx, nsy), angle)

hasCollision :: Player -> [Point] -> Bool
hasCollision (posPlayer, _, _) points = any (\(x, y) -> posPlayer == (x, abs y)) points
