import jester
import db
import os
import asyncdispatch
import json
import strutils
for pair in os.envPairs():
    echo pair
echo "startup..."

const TRUSTED = @["00"]

let redisClient = waitFor(connectdb())

func trustedCheck(token: string): bool =
    if token in TRUSTED:
        return true
    else:
        return false


router subroute:
    get "/":
        resp "Hlo"

    get "/getsub/@sub_id":
        resp await dbgetSub(redisClient, @"sub")


    # get "/addsub/@name/@desc/@image/@token":
    #     if not trustedCheck(@"token"):
    #         resp "unauthorized"
    #     var name = @"name"
    #     var desc = @"desc"
    #     var image = @"image"
    #     await postSub(redisClient, name, desc, image)

    # delete "/getsub/@sub_id/@token":
    #     if not trustedCheck(@"token"):
    #         resp "unauthorized"
    #     resp "delete sub : " & @"sub"


proc main() {.async.} =
    var app = initJester(
      subroute,
         settings = newSettings(
         port = parseInt(os.getEnv("PORT")).PORT
        )
    )
    app.serve()

waitFor(main())







