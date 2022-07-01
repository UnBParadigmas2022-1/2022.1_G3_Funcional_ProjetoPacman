module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Ghost

import Scoreboard
import Coin


drawGame :: Game -> Picture
drawGame (cellSize, width, height, mapa, assets, ghost, score) = 
    pictures [dMap, dScoreboard, dCoin, dGhost]
    where
        dMap = pictures $ Map.drawMapa assets cellSize width mapa (0, 0)
        dScoreboard = Scoreboard.drawScoreboard height score
        dCoin = Coin.drawCoin cellSize assets
        dGhost = Ghost.drawGhost assets cellSize ghost


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, assets, ghost, score) = 
    (cellSize, width, height, mapa, assets, uGhost, uScore)
    where
        uGhost = Ghost.updateGhost ghost
        uScore = (score+1) `mod` 255


inputHandler :: Event -> Game -> Game
inputHandler _ g = g
