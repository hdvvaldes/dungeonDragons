module Main where

import Server.App 

main :: IO()
main = do 
  let env = Env defaultSocket
  _ <- runApp env $ do
    runServer
  putStrLn "Closed Server"
      
