FROM golang:1.12 AS builder
RUN git config --global http.sslverify false
WORKDIR /build/influxdb_stats_exporter/
COPY . .
RUN go mod tidy && \
    make build

FROM busybox:glibc
EXPOSE 9424
USER nobody

COPY --from=builder /build/influxdb_stats_exporter/influxdb_stats_exporter /influxdb_stats_exporter

ENTRYPOINT ["/influxdb_stats_exporter"]
