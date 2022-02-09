FROM golang:1.17-alpine AS builder

WORKDIR /go/src/github.com/seeruk/tsns

ADD . .

RUN set -euxo pipefail \
 && go mod download \
 && CGO_ENABLED=0 go build -ldflags "-s -w" -o tsns .

# Run steps
FROM alpine:3

COPY --from=builder /go/src/github.com/seeruk/tsns/tsns /opt

RUN mkdir -p /usr/share/typesense

ENTRYPOINT ["/opt/tsns"]
