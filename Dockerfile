FROM golang:1.15-alpine AS binary
RUN apk -U add openssl git

ADD . /go/src/github.com/jwilder/dockerize
WORKDIR /go/src/github.com/jwilder/dockerize

RUN go get github.com/robfig/glock
RUN glock sync -n < GLOCKFILE
RUN go install

FROM alpine:3.13

COPY --from=binary /go/bin/dockerize /usr/local/bin

ENTRYPOINT ["dockerize"]
CMD ["--help"]
