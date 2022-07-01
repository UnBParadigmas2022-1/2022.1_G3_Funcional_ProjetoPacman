module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types
import Map
import Player


drawGame :: Game -> Picture
drawGame (cellSize, width, mapa, assets, player) =
    pictures (
        Map.drawMapa assets cellSize width mapa (0, 0)
        ++ Player.drawPlayer cellSize player
    )

updateGame :: Float -> Game -> Game
updateGame dt game = Player.updatePlayer game

inputHandler :: Event -> Game -> Game
inputHandler event game = Player.inputPlayer event game
