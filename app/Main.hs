module Main where

import Utils

x = mapaAtual !! 3 !! 1

main :: IO ()
main = putStrLn ("x = " ++ show x)
