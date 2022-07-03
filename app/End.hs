module End where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types

-- Draw
drawEnd :: Width -> Int -> Picture
drawEnd width score = translate (-width/2 + 40) 50 $ pictures [dTitle, drawSubTitle score]
    where
        dTitle = scale 0.7 0.7 $ color yellow $ text "Voce Perdeu!!!"

drawSubTitle :: Int -> Picture
drawSubTitle score = dScale $ color white $ pictures $ drawTexts dTexts (-200)
    where
        dScale = scale 0.3 0.3
        dTexts = [("Sua Pontuacao: " ++ show score), "Aperte 'M' para ir ao menu."]

drawTexts :: [String] -> Float -> [Picture]
drawTexts [] _ = []
drawTexts (texto:calda) height = (translate 50 height $ text texto) : drawTexts calda (height - 120)

-- Update
endInputHandler :: Event -> Game -> Game
endInputHandler (EventKey (Char 'm') Down _ _) (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) =
    (cellSize, width, height, mapa, assets, player, ghosts, coin, score, MENU)
endInputHandler (EventKey (Char 'M') Up _ _) (cellSize, width, height, mapa, assets, player, ghosts, coin, score, state) =
    (cellSize, width, height, mapa, assets, player, ghosts, coin, score, MENU)
endInputHandler _ g = g
