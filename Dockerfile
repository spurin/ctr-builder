# Stage 1: Download and unpack containerd release
FROM ubuntu:latest AS containerd-downloader

ENV CONTAINERD_VERSION=1.7.27

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    tar \
    ca-certificates

RUN ARCH=$(dpkg --print-architecture) && \
    case "$ARCH" in \
      amd64) CTD_ARCH=amd64 ;; \
      arm64) CTD_ARCH=arm64 ;; \
      *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac && \
    curl -L -o containerd.tar.gz https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/containerd-${CONTAINERD_VERSION}-linux-${CTD_ARCH}.tar.gz && \
    mkdir -p /containerd && \
    tar -xzf containerd.tar.gz -C /containerd

# Final stage: Minimal scratch image with ctr only
FROM scratch
COPY --from=containerd-downloader /containerd/bin/ctr /ctr

CMD ["/ctr"]
