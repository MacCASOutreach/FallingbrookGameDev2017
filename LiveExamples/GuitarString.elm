--Copy this into a 1030-1039 notebook

myShapes model =
    [ curve ( 0, 0 ) [ Pull ( wiggleAmount model * sin (10 * model.time), -8 ) ( 0, -42 ) ]
        |> outlined (solid 1) grey
    , circle 10
        |> filled red
        |> move ( -30, 20 )
        |> notifyTap RedButton
    ]


wiggleAmount model =
    if model.string == Wiggle then
        10
    else
        0


type GuitarString
    = Wiggle
    | NotWiggle


change old =
    case old of
        NotWiggle ->
            Wiggle

        Wiggle ->
            NotWiggle


type Msg
    = Tick Float GetKeyState
    | RedButton


update msg model =
    case msg of
        Tick t _ ->
            { model | time = t }

        RedButton ->
            { model | string = change model.string }


init =
    { time = 0, string = NotWiggle }
