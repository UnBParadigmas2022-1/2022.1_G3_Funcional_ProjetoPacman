module Scoreboard where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

import Types


drawScoreboard :: Height -> Float -> Picture
drawScoreboard height score = translate x y $ scale scaleValue scaleValue $ color white $ text $ "Pontuacao: " ++ show fscore
    where
        scaleValue = 0.3
        fscore = round score
        x = 0
        y = -height + 25
