module HomePage exposing (..)

import Html exposing (Html, a, br, button, div, footer, h1, header, input, nav, p, span, text)
import Html.Attributes exposing (class, href, id, type_)
import CommonParts
import Html.Attributes exposing (value, placeholder, disabled)
import Html.Events exposing (onClick, onInput)
import Session exposing (Session)

-- MODEL
type alias Model =
    { roomCode: String
    , session: Session
    }


init : Session -> (Model, Cmd Msg)
init session  =
  ( Model "" session, Cmd.none )

-- UPDATE

type Msg
  = SetRoomCode String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetRoomCode roomCode ->
            ( { model | roomCode = roomCode }, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW

view : Model -> List (Html Msg)
view model =
  [
    div[ class "container homepage-container" ] [
        printHomePageHeader model,
        div[ id "HomePage" ] [
            p[] [
              span[ class "primary-color pr-1" ] [ text "Typing-Duel.com" ]
              , text "is an internet application, where You can check how fast are You writing."
              , br[][]
              , text "You can train on Your own or create a room and"
              , span [ class "primary-color pr-1 pl-1" ] [ text "duel" ]
              , text "Your friends."
            ],
            a[class "btn large", href "/train" ] [ text "Train" ],
            a[class "btn large outline-primary", href "/createRoom" ] [ text "Create room" ]
        ],
        CommonParts.printFooter
    ]
  ]

printHomePageHeader: Model -> Html Msg
printHomePageHeader model =
    header[ class "main-header homepage-header" ] [
        h1[] [ a[href "/"] [text "Typing-Duel.com"] ],
        div[ class "join-room-form" ] [
           input [ type_ "text", value model.roomCode, onInput SetRoomCode, placeholder "Enter room code" ] [],
           button [ disabled (String.length model.roomCode /= 7) ] [ text "Join" ]
        ]
    ]