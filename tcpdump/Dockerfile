# Use Fedora base image
FROM fedora:latest

# Install tcpdump and clean up the cache
RUN dnf install -y tcpdump \
    && dnf clean all

# Set the default command to run tcpdump with a basic capture option
CMD ["tcpdump", "-i", "any", "-n"]