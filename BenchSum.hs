import Criterion.Main
import qualified Data.Foldable as F
import Prelude
import qualified Prelude as P

myList :: [Int]
myList = [1, 2 .. 10000]

--sum2 :: [Int] -> Int
-- Ten times faster than sum on GHC 7.10.3 and 8.0.1. FFS?
fsum2 :: (F.Foldable t, Num a) => t a -> a
fsum2 xs = F.sum xs

psum2 :: (Num a) => [a] -> a
psum2 xs = P.sum xs

main :: IO ()
main = defaultMain $
  [ bgroup "avgSimpl" [ bench "fsum2" $ nf fsum2 myList
                      , bench "F.sum" $ nf F.sum myList
                      , bench "psum2" $ nf psum2 myList
                      , bench "P.sum" $ nf P.sum myList
                      ]
  ]
