port module FoldButton exposing (..)

import Html exposing (Html, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Html.App


port fold : () -> Cmd msg
port unfold : () -> Cmd msg

type State = Folded | Unfolded
type Action = Fold | Unfold


init : Bool -> (State, Cmd Action)
init foldOnInit =
  case foldOnInit of
    True -> (Folded, fold ())
    False -> (Unfolded, unfold ())


view : State -> Html Action
view state =
    case state of
      Folded -> renderButton Unfold "Expand"
      Unfolded -> renderButton Fold "Collapse"


renderButton : Action -> String -> Html Action
renderButton action name = button [ onClick action, class "btn btn-sm" ] [ text name ]


update : Action -> State -> (State, Cmd Action)
update action state =
    case action of
        Fold -> (Folded, fold ())
        Unfold -> (Unfolded, unfold ())


subscriptions : State -> Sub Action
subscriptions state = Sub.none


main : Program Bool
main =
    Html.App.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions }
