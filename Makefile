# Variables
PERF_IMAGE=quay.io/midu/perf:latest
PERF_DOCKERFILE=./perf

IPERF3_IMAGE=quay.io/midu/iperf3:latest
IPERF3_DOCKERFILE=./iperf3

TCPDUMP_IMAGE=quay.io/midu/tcpdump:latest
TCPDUMP_DOCKERFILE=./tcpdump

CONTAINER_TOOL ?= podman  # Default to Podman, but can be overridden with `make CONTAINER_TOOL=docker`

# Build images
build-perf:
	$(CONTAINER_TOOL) build -t $(PERF_IMAGE) $(PERF_DOCKERFILE)

build-iperf3:
	$(CONTAINER_TOOL) build -t $(IPERF3_IMAGE) $(IPERF3_DOCKERFILE)

build-tcpdump:
	$(CONTAINER_TOOL) build -t $(TCPDUMP_IMAGE) $(TCPDUMP_DOCKERFILE)


# Push images
push-perf:
	$(CONTAINER_TOOL) push $(PERF_IMAGE)

push-iperf3:
	$(CONTAINER_TOOL) push $(IPERF3_IMAGE)

push-tcpdump:
	$(CONTAINER_TOOL) push $(TCPDUMP_IMAGE)

# Clean images
clean-perf:
	$(CONTAINER_TOOL) rmi $(PERF_IMAGE)

clean-iperf3:
	$(CONTAINER_TOOL) rmi $(IPERF3_IMAGE)

clean-tcpdump:
	$(CONTAINER_TOOL) rmi $(TCPDUMP_IMAGE)

# Default build and push all
all: build-perf push-perf build-iperf3 push-iperf3 build-tcpdump push-tcpdump

clean: clean-perf clean-iperf3 clean-tcpdump
