module Menu where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types


-- Draw
drawMenu :: Width -> Picture
drawMenu width = color white $ pictures [drawTitle width, drawSubTitle width]

drawTitle :: Width -> Picture
drawTitle width = translate (-width/3) 0 $ text "Pacman"

drawSubTitle :: Width -> Picture
drawSubTitle width = scale 0.2 0.2 $ translate (-width) (-150) $ text "Aperte Enter para iniciar"


-- Update
menuInputHandler :: Event -> Game -> Game
menuInputHandler (EventKey (SpecialKey KeyEnter) Down _ _) (cellSize, width, mapa, assets, state) = (cellSize, width, mapa, assets, GAME)
menuInputHandler _ g = g