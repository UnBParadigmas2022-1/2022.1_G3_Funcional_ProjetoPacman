module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Player
import Ghost


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, player, ghosts) = pictures $ dMap ++ [dPlayer] ++ [dGhost]
    where
        dMap = Map.drawMapa assets cellSize width mapa (0, 0)
        dPlayer = Player.drawPlayer assets cellSize player
        dGhost = Ghost.drawGhosts ghosts assets cellSize

updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, mapa, assets, player, ghosts) = (cellSize, width, mapa, assets, uPlayer, uGhost)
    where
        uPlayer = Player.updatePlayer player
        uGhost = Ghost.updateGhosts ghosts player

inputHandler :: Event -> Game -> Game
inputHandler event (cellSize, width, mapa, assets, player, ghosts) = (cellSize, width, mapa, assets, iPlayer, ghosts)
    where
        iPlayer = Player.inputPlayer event player
