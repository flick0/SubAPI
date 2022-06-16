ARG REDISHOST
ARG REDISPORT
ARG PORT
FROM ubuntu
ENV REDISHOST $REDISHOST
ENV REDISPORT $REDISPORT
ENV PORT $PORT
EXPOSE $REDISHOST
EXPOSE $REDISPORT
EXPOSE $PORT
RUN "$REDISHOST"
RUN "$REDISPORT"
RUN "$PORT"
ENTRYPOINT ["./"]
COPY ./sub_api /sub_api
RUN ls
RUN chmod +x /sub_api
RUN /sub_api


