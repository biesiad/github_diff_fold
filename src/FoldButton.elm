port module FoldButton exposing (..)

import Html exposing (Html, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Html.App


port setDisplay : String -> Cmd msg


type Model = Folded | Unfolded
type Msg = Fold | Unfold


init : Bool -> (Model, Cmd Msg)
init foldOnInit =
  case foldOnInit of
    True -> (Folded, setDisplay "none")
    False -> (Unfolded, setDisplay "block")


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Fold -> (Folded, setDisplay "none")
    Unfold -> (Unfolded, setDisplay "block" )


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


view : Model -> Html Msg
view model =
  case model of
    Folded -> renderButton Unfold "Expand"
    Unfolded -> renderButton Fold "Collapse"


renderButton : Msg -> String -> Html Msg
renderButton msg name =
  button [ onClick msg, class "btn btn-sm" ] [ text name ]


main : Program Bool
main =
  Html.App.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
