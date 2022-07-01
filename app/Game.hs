module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Ghost

import Scoreboard
import Coin


drawGame :: Game -> Picture
drawGame (cellSize, width, height, mapa, assets, ghost, coin, score) = 
    pictures [dMap, dScoreboard, dCoin, dGhost]
    where
        dMap = pictures $ Map.drawMapa assets cellSize width mapa (0, 0)
        dScoreboard = Scoreboard.drawScoreboard height score
        dCoin = Coin.drawCoin cellSize assets coin
        dGhost = Ghost.drawGhost assets cellSize ghost


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, assets, ghost, coin, score) = 
    (cellSize, width, height, mapa, assets, uGhost, uCoin, uScore)
    where
        uGhost = Ghost.updateGhost ghost
        uScore = (score+1) `mod` 10
        uCoin
            | uScore == 0 = Coin.updateCoin coin
            | otherwise = coin


inputHandler :: Event -> Game -> Game
inputHandler _ g = g
