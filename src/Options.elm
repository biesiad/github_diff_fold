port module Options exposing (..)

import Html exposing (Html, button, text, p, div, h1, span, input)
import Html.Attributes exposing (class, value)
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
      ({ model | regexes = List.filter (not << ((==) id) << .id) model.regexes }, Cmd.none)

    Change id value ->
      ({ model | regexes = List.map (updateRegexes id value) model.regexes }, Cmd.none)


hasId id regex =
  id == regex.id

updateRegexes id value regex =
  if id == regex.id then
    { regex | value = value }
  else
    regex


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Regexes:" ]
    , div [] (List.map renderRegex model.regexes)
    , button [ onClick Add ] [ text "Add" ]
    ]


renderRegex regex =
  div []
    [ span [] [ text (toString regex.id) ]
    , span [] [ text "/" ]
    , input [ onInput (Change regex.id), value regex.value ] []
    , span [] [ text "/" ]
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
