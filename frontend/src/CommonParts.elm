module CommonParts exposing (printHeader, printFooter, getTextToWrite, getTextInWordArray)

import Array exposing (Array)
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

getTextInWordArray : String -> Array String
getTextInWordArray textToDivide =
    Array.fromList ( List.map (\x -> x ++ " ") (String.split " " textToDivide) )


getTextToWrite: String
getTextToWrite =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In convallis viverra dictum. Integer commodo tortor sed dolor aliquet, ut sagittis ante molestie. In hac habitasse platea dictumst. Curabitur eu euismod tellus, non mattis neque. Praesent dapibus suscipit risus eu consequat. Ut commodo, felis eget volutpat vulputate, ligula sapien elementum nibh, et convallis velit velit sit amet metus. Curabitur fringilla pulvinar maximus. Pellentesque bibendum fermentum velit id tincidunt. Ut tempor dapibus nisl, id finibus justo malesuada a. Sed congue ligula a erat lobortis, vitae gravida quam posuere. Quisque rhoncus quis lorem sed auctor. Maecenas risus enim, vehicula non nulla vel, rutrum fringilla magna. Quisque aliquam, nisi ac egestas pellentesque, justo leo faucibus velit, pellentesque convallis turpis erat eget risus. Aenean erat leo, luctus a euismod id, laoreet a sem."
     ++ "In luctus vulputate massa. Mauris a arcu ac risus molestie faucibus sed sit amet quam. Vestibulum eget enim nulla. Aenean venenatis condimentum mi, id dictum tortor. Nulla sit amet aliquet urna. Duis et sapien leo. Mauris accumsan viverra diam, sit amet ullamcorper nibh auctor eget. Aenean congue elementum sapien sit amet sodales. Proin ullamcorper facilisis felis ornare convallis. Fusce vestibulum dolor fringilla eleifend ultrices. Proin fringilla rhoncus nisi, id fermentum elit. Duis a mi aliquet, egestas dui in, placerat odio. Sed lobortis vitae sem eu molestie. Proin tincidunt sagittis malesuada. Curabitur interdum neque in purus facilisis semper."
     ++ "Suspendisse potenti. Duis rutrum ante metus, sit amet molestie leo blandit quis. Maecenas mollis eleifend ligula, nec ultricies ligula aliquet vel. Mauris iaculis ex vitae imperdiet imperdiet. Ut rhoncus eu lorem vel rhoncus. Integer viverra nibh at fermentum mattis. Vestibulum sit amet rhoncus tellus. Sed in neque ac sem lobortis euismod. Nunc volutpat imperdiet interdum."
     ++ "Integer efficitur porttitor odio ut ullamcorper. Mauris gravida suscipit tincidunt. Fusce eget mauris quis sapien finibus lacinia. Proin et lacus felis. Etiam et erat dui. Sed condimentum erat non nisl lacinia malesuada. Sed suscipit nunc vel leo ultrices faucibus. Aliquam vel cursus tortor. Aliquam lacinia, enim non hendrerit facilisis, augue magna consectetur velit, vitae auctor felis sem congue nunc. Cras accumsan lectus eget diam congue, id convallis ex hendrerit. Vivamus congue justo gravida commodo pellentesque."