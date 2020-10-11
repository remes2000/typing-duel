module Train exposing (..)

import Browser
import Browser.Navigation as Nav
import Html.Attributes exposing (value)
import Html.Events exposing (onClick, onInput)
import Html exposing (Html, button, div, input, p, pre, text)
import Session exposing (Session)

-- MODEL


type alias Model =
    { label: String
    , counter: Int
    , session: Session
    }


init : Session -> (Model, Cmd Msg)
init session =
  ( Model "Label" 0 session, Cmd.none )


-- UPDATE


type Msg
  = Increase
  | Decrease
  | SetLabel String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Increase ->
            ({ model | counter = model.counter + 1}, Cmd.none)
        Decrease ->
            ({ model | counter = model.counter - 1}, Cmd.none)
        SetLabel label ->
            ( { model | label = label }, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> List (Html Msg)
view model =
  [
    p[] [text model.label]
  , p[] [text (String.fromInt model.counter)]
  , div[] [button[ onClick Increase ] [ text "Increase" ], button[ onClick Decrease ] [ text "Decrease" ]]
  , input [ value model.label, onInput SetLabel ] []
  ]
