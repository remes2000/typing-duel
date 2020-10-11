module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html.Attributes exposing (href)
import Session exposing (Session)
import Url
import Html exposing (Html, a, div, li, p, text, ul)

import Route
import HomePage
import Train

-- MAIN
main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = ChangedUrl
    , onUrlRequest = ClickedLink
    }

-- MODEL

type Model
    = HomePage HomePage.Model
    | Train Train.Model
    | NotFound Session

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    changeRouteTo (Route.getRouteFromUrl url) (Session.initSession key)

toSession : Model -> Session
toSession model =
    case model of
        HomePage homepageModel -> homepageModel.session
        Train trainModel -> trainModel.session
        NotFound session -> session


-- UPDATE

type Msg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | GotHomePageMsg HomePage.Msg
    | GotTrainMsg Train.Msg

updateWith : (subModel -> Model) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
    (toModel subModel, Cmd.map toMsg subCmd)

update: Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (msg, model) of
        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl (toSession model).navKey (Url.toString url) )
                Browser.External href ->
                    ( model, Nav.load href )

        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.getRouteFromUrl url) (toSession model)

        ( GotHomePageMsg subMsg, HomePage homepage ) ->
            HomePage.update subMsg homepage
                |> updateWith HomePage GotHomePageMsg

        ( GotTrainMsg subMsg, Train train ) ->
            Train.update subMsg train
                |> updateWith Train GotTrainMsg

        ( _, _ ) ->
            ( model, Cmd.none )


changeRouteTo : Maybe Route.Route -> Session -> ( Model, Cmd Msg )
changeRouteTo maybeRoute session =
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )
        Just Route.NotFound ->
            ( NotFound session, Cmd.none )
        Just Route.Home ->
            HomePage.init session
                |> updateWith HomePage GotHomePageMsg
        Just Route.Train ->
            Train.init session
                |> updateWith Train GotTrainMsg

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

-- VIEW
view : Model -> Browser.Document Msg
view model =
    let
        viewPage title body toMsg =
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        HomePage homepageModel -> viewPage "Homepage" (HomePage.view homepageModel) GotHomePageMsg
        Train trainModel -> viewPage "Train" (Train.view trainModel) GotTrainMsg
        NotFound session -> { title = "Test", body = ([div[] [ a [ href "/about" ] [ text "About" ], a [ href "/" ] [ text "Home" ] ]]) }
