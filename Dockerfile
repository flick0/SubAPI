# syntax=docker/dockerfile:1
#FROM nimlang/nim:onbuild
FROM ubuntu
ENTRYPOINT ["./"]
RUN ls
COPY ./sub_api /sub_api
RUN chmod +x /sub_api
RUN /sub_api

