module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Scoreboard

type Game = (CellSize, Width, Height, Mapa)

drawGame :: Game -> Picture
drawGame (cellSize, width, height, mapa) = pictures $ (Map.drawMapa cellSize width mapa (0, 0) ++ [Scoreboard.drawScoreboard height 50])

updateGame :: Float -> Game -> Game
updateGame dt game = game

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
