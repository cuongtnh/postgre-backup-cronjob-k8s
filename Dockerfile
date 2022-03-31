FROM alpine:latest
RUN apk update && apk add postgresql
COPY Backup-Postgre.sh .

ENTRYPOINT [ "/bin/sh" ]
CMD [ "./Backup-Postgre.sh" ]