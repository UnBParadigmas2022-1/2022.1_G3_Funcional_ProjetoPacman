module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Player
import Ghost

import Scoreboard
import Coin


drawGame :: Game -> Picture
drawGame (cellSize, width, height, mapa, assets, player, ghost, coin, score) = 
    pictures [dMap, dPlayer, dGhost, dCoin, dScoreboard]
    where
        dMap = Map.drawMapa assets cellSize width mapa (0, 0)
        dPlayer = Player.drawPlayer assets cellSize player
        dCoin = Coin.drawCoin cellSize assets coin
        dScoreboard = Scoreboard.drawScoreboard height score
        dGhost = Ghost.drawGhost assets cellSize ghost


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, assets, player, ghost, coin, score) = 
    (cellSize, width, height, mapa, assets, uPlayer, uGhost, uCoin, uScore)
    where
        uPlayer = Player.updatePlayer player
        uGhost = Ghost.updateGhost ghost player
        uScore = (score+1) `mod` 10
        uCoin
            | uScore == 0 = Coin.updateCoin coin
            | otherwise = coin


inputHandler :: Event -> Game -> Game
inputHandler event (cellSize, width, mapa, assets, player, ghost) = (cellSize, width, mapa, assets, iPlayer, ghost)
    where
        iPlayer = Player.inputPlayer event player
