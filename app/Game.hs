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
drawGame (cellSize, width, height, mapa, assets, player, ghosts, coins, score, state) = 
    pictures $ dMap ++ [dPlayer] ++ [dGhost] ++ [dCoin] ++ [dScoreboard]
    where
        dMap = Map.drawMapa assets cellSize width mapa (0, 0)
        dPlayer = Player.drawPlayer assets cellSize player
        dCoin = Coin.drawCoins coins assets cellSize 
        dScoreboard = Scoreboard.drawScoreboard height score
        dGhost = Ghost.drawGhosts ghosts assets cellSize


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, assets, player, ghosts, coins, score, state) = 
    (cellSize, width, height, mapa, assets, uPlayer, uGhosts, uCoins, uScore, uState)
    where
        uPlayer = Player.updatePlayer player
        uGhosts = Ghost.updateGhosts ghosts player
        coinCollision = hasCollision uPlayer uCoinsPositions
        uScore = score + 1 + coinPrice coinCollision
        uGhostsPositions = map (\(x, y, _, _) -> (x, y)) uGhosts
        uCoinsPositions = map (\((x, y), _) -> (x, y)) coins
        uState
            | hasCollision player uGhostsPositions = END
            | otherwise = GAME
        uCoins
            | coinCollision = Coin.updateCoins coins player
            | otherwise = coins


gameInputHandler :: Event -> Game -> Game
gameInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) = 
    (cellSize, width, height, mapa, assets, iPlayer, ghosts, coin, score, state)
    where
        iPlayer = Player.inputPlayer event player
