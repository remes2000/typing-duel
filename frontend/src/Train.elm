module Train exposing (..)

import Array exposing (Array)
import Html.Attributes exposing (class, id, value, classList)
import Html.Events exposing (onClick, onInput)
import Html exposing (Html, button, div, input, p, pre, span, text)
import Session exposing (Session)
import CommonParts

-- MODEL

type alias Model =
    { session: Session,
      textToWrite: String,
      words: Array String,
      wordToWriteIndex: Int,
      inputValue: String,
      incorrectInput: Bool
    }


init : Session -> (Model, Cmd Msg)
init session =
  ( Model session CommonParts.getTextToWrite ( CommonParts.getTextInWordArray CommonParts.getTextToWrite) 0 "" False, Cmd.none )

-- UPDATE


type Msg
  = SetInputValue String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let
        wordToWrite =
            case (Array.get model.wordToWriteIndex model.words) of
                Just word ->
                    word
                Nothing ->
                    ""
    in
    case msg of
        SetInputValue value ->
            if value == wordToWrite then
                ( { model | inputValue = "", wordToWriteIndex = model.wordToWriteIndex + 1, incorrectInput = False }, Cmd.none)
            else if String.startsWith value wordToWrite then
                ( { model | inputValue = value, incorrectInput = False }, Cmd.none)
            else
                ( { model | inputValue = value, incorrectInput = True }, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW

view : Model -> List (Html Msg)
view model =
  [
    div[ class "container" ] [
        CommonParts.printHeader,
        div[ id "Train" ]   [
            div[ class "text-to-write-display" ] (divideTextIntoWordPieces model.textToWrite model.wordToWriteIndex)
            , input [ value model.inputValue, classList [
                ("word-input", True),
                ("incorrect-input", model.incorrectInput)
            ], onInput SetInputValue ] []
        ],
        CommonParts.printFooter
    ]
  ]

divideTextIntoWordPieces: String -> Int -> List (Html msg)
divideTextIntoWordPieces textToDivide indexOfWordToUnderline =
    List.indexedMap
        (\index word ->
            if index == indexOfWordToUnderline then
                getUnderlineWordSpan word
            else
                getWordSpan word
        )
        (String.split " " textToDivide)

getWordSpan: String -> (Html msg)
getWordSpan content =
    span[] [text (content ++ " ") ]

getUnderlineWordSpan: String -> (Html msg)
getUnderlineWordSpan content =
    span[ class "word-to-write" ] [ text (content ++ " ") ]
