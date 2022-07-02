module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Player
import Ghost


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, player, ghost, state, algo) = pictures $ dMap ++ [dPlayer] ++ [dGhost]
    where
        dMap = (Map.drawMapa assets cellSize width mapa (0, 0))
        dPlayer = Player.drawPlayer assets cellSize player
        dGhost = Ghost.drawGhost assets cellSize ghost


updateGame :: Float -> Game -> Game
updateGame dt (cellSize, width, mapa, assets, player, ghost, state, algo) =
    (cellSize, width, mapa, assets, uPlayer, uGhost, state, algo)
    where
        uPlayer = Player.updatePlayer player
        uGhost = Ghost.updateGhost ghost player algo


gameInputHandler :: Event -> Game -> Game
gameInputHandler event (cellSize, width, mapa, assets, player, ghost, state, algo) = 
    (cellSize, width, mapa, assets, iPlayer, ghost, state, algo)
    where
        iPlayer = Player.inputPlayer event player
