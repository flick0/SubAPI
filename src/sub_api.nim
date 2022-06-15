import jester
import db
import os
import asyncdispatch
import redis
import json
import std/strutils

echo "startup..."

const TRUSTED = @["00"]



proc main() {.async.} =
  let redisClient = await openAsync(
    host = os.getEnv("REDISHOST"),
    port = parseInt(os.getEnv("REDISPORT")).PORT
    )

  func trustedCheck(token: string): bool =
    if token in TRUSTED:
      return true
    else:
      return false

  routes:
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

waitFor(main())







