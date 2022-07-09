module Screens.Scoreboard where

import Graphics.Gloss
    ( Picture, white, color, scale, text, translate )
import Graphics.Gloss.Interface.Pure.Game
    ( Picture, white, color, scale, text, translate )

import Types ( Height, Score )


drawScoreboard :: Height -> Score -> Picture
drawScoreboard height score = 
    translate x y 
        $ scale scaleValue scaleValue 
        $ color white 
        $ text 
        $ "Pontuacao: " ++ show score
    where
        scaleValue = 0.3
        x = 0
        y = -height + 25
