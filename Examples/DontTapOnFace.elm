myShapes model = [ text "Please don't tap my face!"
                    |> filled red
                    |>move(-60,55)
                   ,circle 50 |> filled (display3 model.f)
                     |> notifyTap FaceTap
                   ,rect 20 2 |> filled black
                     |> move(25,25)
                   ,rect 20 2 |> filled black
                     |> move(-25,25)
                   ,wedge 20 0.5 |> filled black 
                     |> move(0,-20)
                     |> rotate (degrees (mouth model.f))
                   ,(display1 model.shape) 10 |> filled (display2 model.col)

                    |> notifyTap ButtonTap
                     |> makeTransparent 0.1

                    |> move(30 * cos(1.1 * model.time), 50 * cos model.time)
                    |> rotate (degrees (model.time*50))
                  -- ,bee
                   ,text ("Score: " ++toString(model.score)) |> filled black
                 ]



mouth m = case m of
            Red -> 90
            Skin -> -90

display3 face = case face of
                  Skin -> skin
                  Red -> red
                  
faceChange colour = case colour of
                      Skin -> Red
                      Red -> Skin

display1 shape = case shape of
                  Triangle -> triangle
                  Circle -> circle
                  Square -> square

buttonPress oldState = case oldState of
                        Triangle -> Circle
                        Circle -> Square
                        Square -> Triangle

display2 colour = case colour of
                      Green -> green
                      Blue -> blue
                      Pink -> pink
                      Yellow -> yellow

colourChange oldColour = case oldColour of
                            Green -> Pink
                            Pink -> Yellow
                            Yellow -> Blue
                            Blue -> Green

skin = rgb 255 229 204

type Col = Green | Pink | Yellow | Blue

type Face = Skin | Red

type Shape = Triangle | Circle | Square

type Msg = Tick Float GetKeyState
              | ButtonTap
              | FaceTap

update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     ButtonTap -> {model | shape = buttonPress model.shape ,
                                    col = colourChange model.col
                                    ,score = model.score + 1}
                     FaceTap -> {model | f = faceChange model.f}

init = { time = 0 , score = 0, shape = Circle, col = Green, f = Skin}
bee = group[circle 26
                     |> filled yellow
                     |> move (-40,8)
                  , oval 60 50
                     |> filled yellow
                     |> move (5,10)
                  , triangle 15
                     |> filled yellow
                     |> move (45,10)
                     |> scaleX 2
                  , oval 25 30
                     |> filled grey
                     |> move (5,-15)
                  , rect 5 20
                     |> filled black
                     |> move (5,-10)
                  , oval 25 30
                     |> filled grey
                     |> move (4,45)
                  , rect 5 20
                     |> filled blue
                     |> move (5,39)
                  , circle 11
                     |> filled white
                     |> move (-45,13)
                  , circle 8
                     |> filled black
                     |> move (-45,13)
                  , circle 3
                     |> filled white
                     |> move (-50,17)
                  , rect 15 3
                     |> filled black
                     |> move (-52,-10)
                  , rect 10 35
                     |> filled black
                     |> move (-10,10)] |> scale 0.2
