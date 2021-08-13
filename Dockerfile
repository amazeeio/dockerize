FROM golang:1.15-alpine AS binary
RUN apk -U add openssl git

ADD . /go/src/github.com/jwilder/dockerize
WORKDIR /go/src/github.com/jwilder/dockerize

RUN go get github.com/robfig/glock
RUN glock sync -n < GLOCKFILE
RUN go install

FROM alpine:3.13
LABEL org.opencontainers.image.authors="Jason Wilder <mail@jasonwilder.com>" maintainer="tobybellwood"
LABEL org.opencontainers.image.source="https://github.com/tobybellwood/dockerize" repository="https://github.com/tobybellwood/dockerize"

COPY --from=binary /go/bin/dockerize /usr/local/bin

ENTRYPOINT ["dockerize"]
CMD ["--help"]
