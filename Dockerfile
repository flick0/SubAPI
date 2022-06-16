# syntax=docker/dockerfile:1
#FROM nimlang/nim:onbuild
FROM ubuntu
ENTRYPOINT ["./"]
RUN chmod +x ./sub_api
RUN ./sub_api

