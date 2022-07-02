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
drawGame (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) = 
    pictures $ dMap ++ [dPlayer] ++ [dGhost] ++ [dCoin] ++ [dScoreboard]
    where
        dMap = Map.drawMapa assets cellSize width mapa (0, 0)
        dPlayer = Player.drawPlayer assets cellSize player
        dCoin = Coin.drawCoin cellSize assets coin
        dScoreboard = Scoreboard.drawScoreboard height score
        dGhost = Ghost.drawGhosts ghosts assets cellSize


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) = 
    (cellSize, width, height, mapa, assets, uPlayer, uGhost, uCoin, uScore, state)
    where
        uPlayer = Player.updatePlayer player
        uGhost = Ghost.updateGhosts ghosts player
        uScore = (score+1) `mod` 10
        uCoin
            | uScore == 0 = Coin.updateCoin coin
            | otherwise = coin


gameInputHandler :: Event -> Game -> Game
gameInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) = 
    (cellSize, width, height, mapa, assets, iPlayer, ghosts, coin, score, state)
    where
        iPlayer = Player.inputPlayer event player
