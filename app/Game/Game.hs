module Game.Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Game.Map ( drawMapa )
import Game.Player ( drawPlayer, updatePlayer, inputPlayer, hasCollision ) 
import Game.Ghost ( drawGhosts, updateGhosts )
import Game.Coin ( drawCoins, updateCoins, coinPrice )

import Screens.Scoreboard


drawGame :: Game -> Picture
drawGame (cellSize, width, height, mapa, assets, player, ghosts, coins, score, state) = 
    pictures $ dMap ++ [dPlayer] ++ [dGhost] ++ [dCoin] ++ [dScoreboard]
    where
        dMap = drawMapa assets cellSize width mapa (0, 0)
        dPlayer = drawPlayer assets cellSize player
        dCoin = drawCoins coins assets cellSize
        dScoreboard = drawScoreboard height score
        dGhost = drawGhosts ghosts assets cellSize


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, height, mapa, assets, player, ghosts, coins, score, state) = 
    (cellSize, width, height, mapa, assets, uPlayer, uGhosts, uCoins, uScore, uState)
    where
        uPlayer = updatePlayer player
        uGhosts = updateGhosts ghosts player
        coinCollision = hasCollision uPlayer uCoinsPositions
        uScore = score + 1 + coinPrice coinCollision
        uGhostsPositions = map (\(x, y, _, _) -> (x, y)) uGhosts
        uCoinsPositions = map (\((x, y), _) -> (x, y)) coins
        uState
            | hasCollision player uGhostsPositions = END
            | otherwise = GAME
        uCoins
            | coinCollision = updateCoins coins player
            | otherwise = coins


gameInputHandler :: Event -> Game -> Game
gameInputHandler event (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) = 
    (cellSize, width, height, mapa, assets, iPlayer, ghosts, coin, score, state)
    where
        iPlayer = inputPlayer event player
