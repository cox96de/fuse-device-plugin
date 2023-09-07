FROM golang:1.20 as builder
ADD . /src
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN cd /src && CGO_ENABLED=0 go build -o fuse-device-plugin .
FROM debian:stretch-slim
COPY --from=builder /src/fuse-device-plugin /usr/bin/fuse-device-plugin

CMD ["fuse-device-plugin"]
