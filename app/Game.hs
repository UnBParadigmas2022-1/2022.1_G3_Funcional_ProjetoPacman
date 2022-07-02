module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Player
import Ghost


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, player, ghosts, state) =
    pictures [dMap, dPlayer, dGhost]
    where
        dMap = pictures $ Map.drawMapa assets cellSize width mapa (0, 0)
        dPlayer = Player.drawPlayer assets cellSize player
        dGhost = Ghost.drawGhosts ghosts assets cellSize


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, mapa, assets, player, ghosts, state) =
    (cellSize, width, mapa, assets, uPlayer, uGhosts, uState)
    where
        uPlayer = Player.updatePlayer player
        uGhosts = Ghost.updateGhosts ghosts player
        uGhostsPositions = map (\(x, y, _, _) -> (x, y)) uGhosts
        uState
            | hasCollision player uGhostsPositions = END
            | otherwise = GAME


gameInputHandler :: Event -> Game -> Game
gameInputHandler event (cellSize, width, mapa, assets, player, ghosts, state) = 
    (cellSize, width, mapa, assets, iPlayer, ghosts, state)
    where
        iPlayer = Player.inputPlayer event player
