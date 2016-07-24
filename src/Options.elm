port module Options exposing (..)

import Html exposing (Html, button, text, p, div, h2, h3, span, input, br)
import Html.Attributes exposing (class, value, src)
import Html.Events exposing (onClick, onInput)
import Html.App


port save : List String -> Cmd msg


type alias Model = { regexes : List Regex, lastId : Int }
type alias Regex = { value : String, id : Int }
type Msg = Add | Remove Int | Change Int String


init : List String -> (Model, Cmd Msg)
init values =
  let
    lastId = List.length values
  in
    (Model (List.foldl initRegexes [] values) (lastId - 1), Cmd.none)


initRegexes values acc =
  acc ++ [ Regex values (List.length acc) ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Add ->
      (Model (model.regexes ++ [ Regex "" (model.lastId + 1)]) (model.lastId + 1) , Cmd.none)

    Remove id ->
      let
        newRegexes = List.filter (not << ((==) id) << .id) model.regexes
      in
        ({ model | regexes = newRegexes }, save (List.map .value newRegexes))

    Change id value ->
      let
        newRegexes = List.map (updateRegexValue id value) model.regexes
      in
        ({ model | regexes = newRegexes }, save (List.map .value newRegexes))


updateRegexValue id value regex =
  if id == regex.id then
    { regex | value = value }
  else
    regex


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


view : Model -> Html Msg
view model =
  div [ class "container" ]
    [ Html.img [ src "icon.png", class "icon" ] []
    , h2 [] [ text "Github diff fold" ]
    , p [ class "small" ]
      [ text "Select files collapsed by default, use RegExp e.g. "
      , span [ class "code" ] [ text "/^.+postcss.css$/" ]
      , text "."
      ]
    , br [] []
    , div [ class "row" ] (List.map renderRegex model.regexes)
    , div [ class "row" ] [ button [ onClick Add ] [ text "Add new pattern" ] ]
    ]


renderRegex regex =
  div [ class "row" ]
    [ span [ class "strong" ] [ text "/" ]
    , input [ onInput (Change regex.id), value regex.value ] []
    , span [ class "strong" ] [ text "/" ]
    , button [ onClick (Remove regex.id) ] [ text "Remove" ]
    ]


main : Program (List String)
main =
  Html.App.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
