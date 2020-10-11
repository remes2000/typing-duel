module Session exposing (..)

import Browser.Navigation as Nav

type alias Session
    = {
        navKey: Nav.Key
    }

initSession : Nav.Key -> Session
initSession key =
    { navKey = key }