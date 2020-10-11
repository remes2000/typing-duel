module CommonParts exposing (printHeader, printFooter)

import Html exposing (Html, a, footer, h1, header, p, text)
import Html.Attributes exposing (class, href)

printHeader: Html msg
printHeader =
    header[ class "main-header" ] [
        h1[] [ a[href "/"] [text "Typing-Duel.com"] ]
    ]

printFooter: Html msg
printFooter =
    footer[ class "main-footer" ] [
        p[] [ text "Written in Elm by", a[ href "https://nieruchalski.pl" ] [ text "Michał Nieruchalski" ], text "AD 2020"],
        p[] [ text "Contact: ", a[ href "mailto:michal@nieruchalski.pl"] [ text "michal@nieruchalski.pl" ] ]
    ]