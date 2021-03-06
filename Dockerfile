FROM golang:1.12.9 as builder

WORKDIR /go/src/github.com/gramarr
COPY "${PWD}" /go/src/github.com/gramarr
ENV GO111MODULE=on
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
      go build \
      -mod=vendor \
      -a -installsuffix cgo -o ./build/gramarr .

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/gramarr/build/gramarr /usr/bin/gramarr
