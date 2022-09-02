module Game.Coin where

import System.Random ( StdGen, randomR )
import Graphics.Gloss ( Picture, pictures, translate )
import GHC.Float ( int2Float )

import Game.Map ( mapaWidth, mapaHeight, isCellFree )
import Types ( Assets, CellSize, Coin, Coins, Player )


drawCoin :: Assets -> Float -> Coin -> Picture
drawCoin [_, _, _, _, _, _, coin, _, _] cellSize ((x, y), _) =
    translate newX newY coin
    where
        newX = x * cellSize
        newY = y * cellSize

drawCoins :: Coins -> Assets -> CellSize -> Picture
drawCoins coins assets cellSize = pictures $ map (drawCoin assets cellSize) coins

coinPrice :: Bool -> Int
coinPrice True = 10
coinPrice False = 0

generateRandom :: StdGen -> (Int, Int) -> (Int, StdGen)
generateRandom seed range = randomR range seed

updateCoins :: Coins -> Player -> Coins
updateCoins coins player = map (updateCoin player) coins

updateCoin :: Player -> Coin -> Coin
updateCoin player (pos, seed)
    | randomPosIsFree = (random, ySeed)
    | otherwise = updateCoin player (pos, ySeed)
    where
        (x, xSeed) = generateRandom seed (0 :: Int, round (mapaWidth-1))
        (y, ySeed) = generateRandom xSeed (0 :: Int, round (mapaHeight-1))
        randomPosIsFree = isCellFree random
        random = (int2Float x, -(int2Float y))
