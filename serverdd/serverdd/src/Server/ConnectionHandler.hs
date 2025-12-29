module Server.ConnectionHandler where


--runConn :: (Socket, SockAddr) -> IO()
--runConn (s, _) = do 
--  hdl <- socketToHandle s ReadWriteMode
--  hSetBuffering hdl LineBuffering
--  echoInput hdl
--
--echoInput :: Handle -> IO ()
--echoInput hdl = do 
--  msg <- hGetLine hdl
--  hPutStrLn hdl msg
