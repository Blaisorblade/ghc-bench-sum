import Criterion.Main
import qualified Data.Foldable as F
import Prelude
import qualified Prelude as P

myList :: [Int]
myList = [1, 2 .. 10000]

-- Ten times faster than sum on GHC 7.10.3 and 8.0.1. FFS?
fsum1 :: (F.Foldable t, Num a) => t a -> a
fsum1 xs = F.foldl (+) 0 xs

fsum0 :: (F.Foldable t, Num a) => t a -> a
fsum0 = F.foldl (+) 0

psum1 :: (Num a) => [a] -> a
psum1 xs = P.foldl (+) 0 xs

psum0 :: (Num a) => [a] -> a
psum0 = P.foldl (+) 0

main :: IO ()
main = defaultMain $
  [ bgroup "avgSimpl" [ bench "fsum2" $ nf fsum1 myList
                      , bench "fsum1" $ nf fsum0 myList
                      , bench "psum2" $ nf psum1 myList
                      , bench "P.sum" $ nf psum0 myList
                      ]
  ]
