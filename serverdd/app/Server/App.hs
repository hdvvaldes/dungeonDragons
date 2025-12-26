module Server.App(
  run,
  defaultConfig
) where

import qualified Network.Socket as NS
import Server.ReaderT

data SocketConfig = SocketConfig {
  socketFamily :: NS.Family,
  socketType :: NS.SocketType,
  socketProto :: NS.ProtocolNumber
}

defaultConfig :: SocketConfig
defaultConfig = 
  SocketConfig {
  socketFamily = NS.AF_INET, 
  socketType = NS.Stream,
  socketProto = NS.defaultProtocol
}

defaultSocket :: SocketConfig
defaultSocket = 
  SocketConfig {
  socketFamily = NS.AF_INET, 
  socketType = NS.Stream,
  socketProto = NS.defaultProtocol
}


type App a = ReaderT SocketConfig  a

--run :: App ()
run = undefined

-- run :: IO()
-- run = do
--   sock <-
--   bind sock scktAddr
--   let maxConn = 2
--     in listen sock maxConn
-- 
-- scktAddr :: SockAddr
-- scktAddr = SockAddrInet port host
--           where
--           port = 8080 :: PortNumber
--           host = tupleToHostAddress (127,0,0,1)
-- 
-- mainLoop :: Socket -> IO()
-- mainLoop sock = do
--   conn <- accept sock
--   runConn conn
--   mainLoop sock

