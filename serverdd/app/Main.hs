module Main where

import Network.Socket
import System.IO


main :: IO ()
main = do
  sock <- 
    let scktFamily = AF_INET  --ipv4
        scktType = Stream
        -- defaultProtocol = 0
        scktProtocol = defaultProtocol
      in 
        socket scktFamily scktType scktProtocol
  bind sock scktAddr 
  let maxConn = 2 
    in listen sock maxConn
  mainLoop sock

mainLoop :: Socket -> IO()
mainLoop sock = do
  conn <- accept sock  
  runConn conn
  mainLoop sock

runConn :: (Socket, SockAddr) -> IO()
runConn (s, _) = do 
  hdl <- socketToHandle s ReadWriteMode
  hSetBuffering hdl LineBuffering
  echoInput hdl 

echoInput :: Handle -> IO ()
echoInput hdl = do 
  msg <- hGetLine hdl
  hPutStrLn hdl msg

scktAddr :: SockAddr
scktAddr = SockAddrInet port host
          where 
          port = 8080 :: PortNumber
          host = tupleToHostAddress (127,0,0,1)
