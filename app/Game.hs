module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map

type Game = (CellSize, Width, Mapa)

drawGame :: Game -> Picture
drawGame (cellSize, width, mapa) = pictures (Map.drawMapa cellSize width mapa 0 0)

updateGame :: Float -> Game -> Game
updateGame dt game = game

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
