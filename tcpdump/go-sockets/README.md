# Socket Creation and Management

This Go program demonstrates how to create and manage multiple raw sockets in batches. It creates up to 1000 raw sockets (using `AF_PACKET` and `SOCK_RAW`), with a maximum batch size of 50 sockets created every 5 seconds. The program waits for a termination signal (specifically `SIGBUS`, signal 7), then gracefully closes all the created sockets before exiting.

## Features
- **Batch Socket Creation**: Opens raw sockets in batches to manage system resources efficiently.
- **Graceful Shutdown**: Listens for the `SIGBUS` signal to close all opened sockets before the program terminates.
- **Customizable Parameters**: You can change the maximum number of sockets (`maxSockets`) and batch size (`batchSize`) as per your needs.

## Requirements
- Go 1.16 or higher
- Linux-based system (since it uses low-level socket system calls like `AF_PACKET` and `SOCK_RAW`)

## How to Use

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Build the application**:
   ```bash
   go build -o socket-manager
   ```

3. **Run the application**:
   ```bash
   sudo ./socket-manager
   ```
   (Note: You may need `sudo` privileges to create raw sockets on most systems.)

   This will start creating sockets in batches, with periodic updates on the number of sockets opened. Once the program receives the `SIGBUS` signal, it will begin closing all sockets.

## Code Breakdown

- **Constants**:
  - `maxSockets`: The maximum number of sockets to create (1000 by default).
  - `batchSize`: The number of sockets to create in each batch (50 by default).
  
- **Socket Creation**:
  - The program creates raw sockets using the system call `syscall.Socket` with the `AF_PACKET` address family and the `SOCK_RAW` socket type.

- **Signal Handling**:
  - The program listens for the `SIGBUS` signal (signal 7) to gracefully shut down. Upon receiving this signal, the program proceeds to close all open sockets.

- **Socket Cleanup**:
  - Before exiting, all open sockets are closed to release system resources.

## Example Output

```
Opened 50 sockets so far...
Opened 100 sockets so far...
Opened 150 sockets so far...
...
Opened 1000 sockets so far...
All sockets created successfully!
<Program waits for SIGBUS>
All sockets closed successfully!
```

## Notes
- **Permissions**: Creating raw sockets typically requires root privileges. Make sure to run the program with sufficient permissions (e.g., `sudo`).
- **System Resources**: Opening a large number of raw sockets can have a significant impact on system resources. Make sure to monitor your system's performance while running the program.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.