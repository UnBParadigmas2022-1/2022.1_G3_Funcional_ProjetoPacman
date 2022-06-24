module Game where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Map


type Game = Mapa


game = Map.mapaAtual


drawGame :: Game -> Picture
drawGame game = Circle 50

updateGame :: Float -> Game -> Game
updateGame dt game = game

inputHandler :: Event -> Game -> Game
inputHandler _ g = g
