# Use Fedora base image
FROM fedora:latest

# Install perf tool and clean up the cache
RUN dnf install -y perf \
    && dnf clean all

# Set the default command to sleep indefinitely (to allow interaction)
CMD ["sleep", "infinity"]
