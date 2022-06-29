module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, state) = pictures (Map.drawMapa assets cellSize width mapa (0, 0))

updateGame :: Float -> Game -> Game
updateGame dt game = game

gameInputHandler :: Event -> Game -> Game
gameInputHandler _ g = g

