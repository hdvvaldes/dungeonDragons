module Server.ConnectionHandler (
  runConn


) where
import Network.Socket (Socket, SockAddr, socketToHandle)
import GHC.IO.Handle (Handle, hSetBuffering, BufferMode (LineBuffering), hGetLine)
import GHC.IO.IOMode (IOMode(ReadWriteMode))
import GHC.IO.Handle.Text (hPutStrLn)


runConn :: (Socket, SockAddr) -> IO ()
runConn (s, _) = do 
  hdl <- socketToHandle s ReadWriteMode
  hSetBuffering hdl LineBuffering
  echoInput hdl

echoInput :: Handle -> IO ()
echoInput hdl = do 
  msg <- hGetLine hdl
  hPutStrLn hdl msg
