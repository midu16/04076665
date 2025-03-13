# Use Fedora base image
FROM registry.fedoraproject.org/fedora:latest

# Install necessary dependencies including Golang
RUN dnf install -y tcpdump golang \
    && dnf clean all

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source code into the container
COPY ./go-sockets/main.go .

# Build the Go binary
RUN go build -o socket_app main.go

# Set the default entrypoint to run the Go binary
ENTRYPOINT ["/app/socket_app"]
