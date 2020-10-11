module Route exposing (..)

import Url
import Url.Parser as Parser exposing (Parser, oneOf, s, map, top)

type Route
    = Home
    | Train
    | NotFound

parser : Parser (Route -> a) a
parser =
    oneOf
    [ map Home top
     ,map Train (s "train")
    ]

getRouteFromUrl : Url.Url -> Maybe Route
getRouteFromUrl url =
    Parser.parse parser url