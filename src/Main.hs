import Web.Twitter.Conduit.Base
import Web.Twitter.Conduit
import Web.Twitter.Conduit.Api
import Network.HTTP.Conduit
import Common
import Control.Lens
import Web.Twitter.Conduit.Lens
import Data.Conduit
import qualified Data.Conduit.List as CL
import Control.Monad.IO.Class

main =
  do
    twInfo <- getTWInfoFromEnv
    let source mgr = sourceWithCursor twInfo mgr (friendsList (ScreenNameParam "happynaught"))
    let sink = CL.mapM_ (\blah -> (liftIO $ putStrLn $ show blah))
    withManager $ \mgr -> source mgr $$ sink
