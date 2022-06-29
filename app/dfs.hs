module DepthFirstSearch where

import Data.Foldable (asum)
import Data.List     ((\\))

-- generico dfs
dfs :: (Eq a) => (a -> [a]) -> a -> a -> Maybe [a]
dfs next start goal = loop [] start where
    loop path current
          | current == goal = Just . reverse $ goal : path
          | null nexts      = Nothing
          | otherwise       = asum . map (loop (current : path)) $ nexts
          where nexts = next current \\ path