import redis
import json
import asyncdispatch


proc postSub*(
    redis: AsyncRedis,
    name: string,
    desc: string,
    image: string
    ) {.async.} =
  await redis.setk("Sub:"&name, "{\"name\":\""&name&"\",\"desc\":\""&desc&"\",\"image\":\""&image&"\"}")

proc getSub*(redis: AsyncRedis, name: string): Future {.async.} =
  return parseJson(await redis.get("Sub:"&name))



