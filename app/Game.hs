module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Ghost


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, ghost, state, algo) = pictures $ (Map.drawMapa assets cellSize width mapa (0, 0)) ++ [dGhost]
    where 
        dGhost = Ghost.drawGhost assets cellSize ghost

updateGame :: Game -> Game
updateGame (cellSize, width, mapa, assets, ghost, state, algo) = (cellSize, width, mapa, assets, uGhost, state, algo)
    where 
        uGhost = Ghost.updateGhost ghost algo

gameInputHandler :: Event -> Game -> Game
gameInputHandler _ g = g

