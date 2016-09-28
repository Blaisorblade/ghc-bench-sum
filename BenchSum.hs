import Criterion.Main

myList :: [Int]
myList = [1, 2 .. 10000]

--sum2 :: [Int] -> Int
-- Ten times faster than sum. FFS?
sum2 :: (Foldable t, Num a) => t a -> a
sum2 xs = sum xs

main :: IO ()
main = defaultMain $
  [ bgroup "avgSimpl" [ bench "sum2" $ nf sum2 myList
                      , bench "sum" $ nf sum myList
                      ]
  ]
