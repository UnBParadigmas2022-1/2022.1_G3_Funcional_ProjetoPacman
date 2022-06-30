module Scoreboard where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types


type Score = Int


drawScoreboard :: Height -> Score -> Picture
drawScoreboard height score = translate x y $ scale scaleValue scaleValue $ color white $ text $ "Pontuacao: " ++ show score
    where
        scaleValue = 0.3
        x = 0
        y = -height + 25
