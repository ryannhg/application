module Route exposing (Route(..), fromUrl, toUrl)

import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, map, s, string, top)


type Route
    = Homepage
    | SignIn
    | About
    | Careers
    | NotFound


fromUrl : Url -> Route
fromUrl url =
    url
        |> Parser.parse
            (Parser.oneOf
                [ map Homepage top
                , map About (s "about")
                , map SignIn (s "sign-in")
                , map Careers (s "careers")
                ]
            )
        |> Maybe.withDefault NotFound


toUrl : Route -> Url -> Url
toUrl route url =
    { url
        | path =
            "/"
                ++ (String.join "/" <|
                        case route of
                            Homepage ->
                                []

                            About ->
                                [ "about" ]

                            SignIn ->
                                [ "sign-in" ]

                            Careers ->
                                [ "careers" ]

                            NotFound ->
                                [ "not-found" ]
                   )
    }
