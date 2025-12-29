module Main where

import Server.App 

main :: IO()
main = do 
  let sktConfig = dSocketConfig
  let env = Env sktConfig
  _ <- runApp env $ do
    runServer
  putStrLn "Closed Server"
      
