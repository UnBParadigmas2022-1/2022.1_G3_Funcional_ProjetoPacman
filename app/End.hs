module End where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types

-- Draw
drawEnd :: Width -> Picture
drawEnd width = translate (-width/2 + 40) 50 $ pictures [dTitle, drawSubTitle]
    where
        dTitle = scale 0.7 0.7 $ color yellow $ text "Voce Perdeu!!!"

drawSubTitle :: Picture
drawSubTitle = dScale $ color white $ pictures $ drawTexts dTexts (-200)
    where
        dScale = scale 0.3 0.3
        dTexts = [("Sua Pontuacao: " ++ "10"), "Aperte 'M' para ir ao menu."]

drawTexts :: [String] -> Float -> [Picture]
drawTexts [] _ = []
drawTexts (texto:calda) height = (translate 50 height $ text texto) : drawTexts calda (height - 120)

-- Update
endInputHandler :: Event -> Game -> Game
endInputHandler (EventKey (Char 'm') Down _ _) (cellSize, width, mapa, assets, player, ghosts, state) = (cellSize, width, mapa, assets, player, ghosts, MENU)
endInputHandler _ g = g
