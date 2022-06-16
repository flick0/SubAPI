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
        resp "Hello, World! "

    get "/getsub":
        resp "sub"

    get "/getsub/@sub_id":
        resp "sub : " & @"sub"

    post "/postsub/@token":
        if not trustedCheck(@"token"):
            resp "unauthorized"
        var push = parseJson(@"payload")
        var name = push["name"].getStr()
        var desc = push["desc"].getStr()
        var image = push["image"].getStr()
        await postSub(redisClient, name, desc, image)

    delete "/getsub/@sub_id/@token":
        if not trustedCheck(@"token"):
            resp "unauthorized"
        resp "delete sub : " & @"sub"


proc main() {.async.} =
    var app = initJester(
      subroute,
         settings = newSettings(
         port = parseInt(os.getEnv("PORT")).PORT
        )
    )
    app.serve()

waitFor(main())







