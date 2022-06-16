import redis
import os
import strutils
import asyncdispatch

proc connectdb*(): Future[AsyncRedis]{.async.} =
  return await openAsync(
    host = os.getEnv("REDISHOST"),
    port = parseInt(os.getEnv("REDISPORT")).PORT
    )

proc dbpostSub*(
    redis: AsyncRedis,
    name: string,
    desc: string,
    image: string
    ) {.async.} =
  await redis.setk("Sub:"&name, "{\"name\":\""&name&"\",\"desc\":\""&desc&"\",\"image\":\""&image&"\"}")

proc dbgetSub*(redis: AsyncRedis, name: string): Future[string] {.async.} =
  return await redis.get("Sub:"&name)



