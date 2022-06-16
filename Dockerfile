FROM nimlang/nim:onbuild
ENTRYPOINT ["./"]
RUN chmod +x ./sub_api
RUN ./sub_api

