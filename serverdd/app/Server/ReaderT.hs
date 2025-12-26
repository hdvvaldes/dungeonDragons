module Server.ReaderT(
  ReaderT,
  asks, 
  lift
) where 

newtype ReaderT e m a =  
  ReaderT {runReaderT :: e -> m a}
instance Functor m => Functor (ReaderT e m) 
  where 
    fmap f (ReaderT res) = 
      ReaderT $ \env -> fmap f (res env)
instance Applicative m => Applicative (ReaderT e m)
  where 
    pure a = ReaderT $ \_ -> pure a 
    ReaderT f <*> ReaderT a = ReaderT $ \env -> 
      f env <*> a env
instance Monad m => Monad (ReaderT e m)
  where 
  ReaderT funcA >>= t = ReaderT $ \env -> 
    let 
      stack = funcA env
    in  
       

ask :: Monad m => ReaderT e m e
ask = undefined

asks :: Monad m => (e -> a) -> ReaderT e m a
asks f = undefined

lift :: Monad m => (a1 -> r) -> m a1 -> m r
lift = undefined


