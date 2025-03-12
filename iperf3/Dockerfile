# Use Fedora base image
FROM fedora:latest

# Install iperf3 and clean up the cache
RUN dnf install -y iperf3 \
    && dnf clean all

# Set the default command to run iperf3 in server mode (default: 5201 port)
CMD ["iperf3", "-s"]