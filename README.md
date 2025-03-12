# Replicator [#04076665](https://access.redhat.com/support/cases/#/case/04076665/)

## Environment

OCP 4.14.35

MultiNodeOpenShift 

## Building the perf OCI:

```bash
midu$ make all
podman   build -t quay.io/midu/perf:latest ./perf
STEP 1/3: FROM fedora:latest
STEP 2/3: RUN dnf install -y perf     && dnf clean all
--> Using cache f8a798778d4fbf4d27a9ab5dc85005f9853f5bed66f25b6b913d0d69428cfa16
--> f8a798778d4f
STEP 3/3: CMD ["sleep", "infinity"]
--> Using cache 4579ca151e956e4839a5e963aad668f45d49d08b0c04206d575ad132c8651d41
COMMIT quay.io/midu/perf:latest
--> 4579ca151e95
Successfully tagged quay.io/midu/perf:latest
Successfully tagged localhost/ubi-perf-image:latest
4579ca151e956e4839a5e963aad668f45d49d08b0c04206d575ad132c8651d41
podman   push quay.io/midu/perf:latest
Getting image source signatures
Copying blob c2a8ca73c8f0 done   | 
Copying blob 7ef99564a1f4 skipped: already exists  
Copying config 4579ca151e done   | 
Writing manifest to image destination
podman   build -t quay.io/midu/iperf3:latest ./iperf3
STEP 1/3: FROM fedora:latest
STEP 2/3: RUN dnf install -y iperf3     && dnf clean all
Updating and loading repositories:
 Fedora 41 - x86_64 - Updates           100% |   5.6 MiB/s |  11.4 MiB |  00m02s
 Fedora 41 openh264 (From Cisco) - x86_ 100% |   3.3 KiB/s |   6.0 KiB |  00m02s
 Fedora 41 - x86_64                     100% |   4.9 MiB/s |  35.4 MiB |  00m07s
Repositories loaded.
Total size of inbound packages is 216 KiB. Need to download 216 KiB.
After this operation, 560 KiB extra will be used (install 560 KiB, remove 0 B).
Package       Arch   Version       Repository      Size
Installing:
 iperf3       x86_64 3.17.1-2.fc41 fedora     292.8 KiB
Installing dependencies:
 lksctp-tools x86_64 1.0.20-1.fc41 updates    267.0 KiB

Transaction Summary:
 Installing:         2 packages

[1/2] lksctp-tools-0:1.0.20-1.fc41.x86_ 100% | 150.3 KiB/s |  97.1 KiB |  00m01s
[2/2] iperf3-0:3.17.1-2.fc41.x86_64     100% | 141.7 KiB/s | 118.7 KiB |  00m01s
--------------------------------------------------------------------------------
[2/2] Total                             100% | 134.4 KiB/s | 215.8 KiB |  00m02s
Running transaction
[1/4] Verify package files              100% |   0.0   B/s |   2.0   B |  00m00s
[2/4] Prepare transaction               100% |  83.0   B/s |   2.0   B |  00m00s
[3/4] Installing lksctp-tools-0:1.0.20- 100% |  37.9 MiB/s | 271.5 KiB |  00m00s
[4/4] Installing iperf3-0:3.17.1-2.fc41 100% |  19.2 MiB/s | 294.9 KiB |  00m00s
Complete!
Removed 20 files, 11 directories. 0 errors occurred.
--> 6e48cf8574b3
STEP 3/3: CMD ["iperf3", "-s"]
COMMIT quay.io/midu/iperf3:latest
--> ce74429e3dfa
Successfully tagged quay.io/midu/iperf3:latest
ce74429e3dfae907d87f273f55ce80cb4b366531bfeff35e911741af425b0290
podman   push quay.io/midu/iperf3:latest
Getting image source signatures
Copying blob 7ef99564a1f4 skipped: already exists  
Copying blob 98f7f0772e30 done   | 
Copying config ce74429e3d done   | 
Writing manifest to image destination
podman   build -t quay.io/midu/tcpdump:latest ./tcpdump
STEP 1/3: FROM fedora:latest
STEP 2/3: RUN dnf install -y tcpdump     && dnf clean all
Updating and loading repositories:
 Fedora 41 - x86_64 - Updates           100% |   2.9 MiB/s |  11.3 MiB |  00m04s
 Fedora 41 openh264 (From Cisco) - x86_ 100% |   3.7 KiB/s |   6.0 KiB |  00m02s
 Fedora 41 - x86_64                     100% |   7.2 MiB/s |  35.4 MiB |  00m05s
Repositories loaded.
Package     Arch   Version          Repository      Size
Installing:
 tcpdump    x86_64 14:4.99.5-1.fc41 fedora       1.2 MiB
Installing dependencies:
 libibverbs x86_64 51.0-5.fc41      updates      1.2 MiB
 libnl3     x86_64 3.11.0-1.fc41    updates      1.0 MiB
 libpcap    x86_64 14:1.10.5-1.fc41 fedora     415.4 KiB

Transaction Summary:
 Installing:         4 packages

Total size of inbound packages is 1 MiB. Need to download 1 MiB.
After this operation, 4 MiB extra will be used (install 4 MiB, remove 0 B).
[1/4] libpcap-14:1.10.5-1.fc41.x86_64   100% | 260.4 KiB/s | 177.6 KiB |  00m01s
[2/4] tcpdump-14:4.99.5-1.fc41.x86_64   100% | 593.0 KiB/s | 502.3 KiB |  00m01s
[3/4] libibverbs-0:51.0-5.fc41.x86_64   100% | 483.0 KiB/s | 435.7 KiB |  00m01s
[4/4] libnl3-0:3.11.0-1.fc41.x86_64     100% |   1.5 MiB/s | 352.9 KiB |  00m00s
--------------------------------------------------------------------------------
[4/4] Total                             100% | 716.6 KiB/s |   1.4 MiB |  00m02s
Running transaction
[1/6] Verify package files              100% |   1.3 KiB/s |   4.0   B |  00m00s
[2/6] Prepare transaction               100% | 137.0   B/s |   4.0   B |  00m00s
[3/6] Installing libnl3-0:3.11.0-1.fc41 100% | 104.8 MiB/s |   1.0 MiB |  00m00s
[4/6] Installing libibverbs-0:51.0-5.fc 100% | 100.8 MiB/s |   1.2 MiB |  00m00s
[5/6] Installing libpcap-14:1.10.5-1.fc 100% |  17.7 MiB/s | 417.5 KiB |  00m00s
>>> Running pre-install scriptlet: tcpdump-14:4.99.5-1.fc41.x86_64              
>>> Finished pre-install scriptlet: tcpdump-14:4.99.5-1.fc41.x86_64             
>>> Scriptlet output:                                                           
>>> useradd: Warning: missing or non-executable shell '/usr/sbin/nologin'       
>>>                                                                             
[6/6] Installing tcpdump-14:4.99.5-1.fc 100% |  58.3 MiB/s |   1.2 MiB |  00m00s
Complete!
Removed 20 files, 11 directories. 0 errors occurred.
--> 37e0213b220d
STEP 3/3: CMD ["tcpdump", "-i", "any", "-n"]
COMMIT quay.io/midu/tcpdump:latest
--> e3feac8703a9
Successfully tagged quay.io/midu/tcpdump:latest
e3feac8703a9dfb52d7062ff3e7bad678fa72bf6ffbaa6b711c5118f35d49f56
podman   push quay.io/midu/tcpdump:latest
Getting image source signatures
Copying blob c811715fa8df done   | 
Copying blob 7ef99564a1f4 skipped: already exists  
Copying config e3feac8703 done   | 
Writing manifest to image destination
```

> [!NOTE]
> The Makefile can be used in the situation the user doesnt want to use the already build images available here:
> - quay.io/midu/tcpdump:latest
> - quay.io/midu/iperf3:latest
> - quay.io/midu/perf:latest


## Running the Replicator Deployment:

> [!NOTE]
> Ensure to change the [Deployment CR](/replicator.yaml) to match your environment. The section that requires update its outlined by `Specify the exact node name here` note.

- Connect to the node for collecting `perf data`:


> [!NOTE]
> [How to collect!](https://access.redhat.com/solutions/386343) the perf data.
> [How to read it!](https://access.redhat.com/solutions/503663) the perf data.


```bash
[root@INBACRNRDL0102 ~]# ssh hub-ctlplane-0
Red Hat Enterprise Linux CoreOS 414.92.202408100542-0
  Part of OpenShift 4.14, RHCOS is a Kubernetes native operating system
  managed by the Machine Config Operator (`clusteroperator/machine-config`).

WARNING: Direct SSH access to machines is not recommended; instead,
make configuration changes via `machineconfig` objects:
  https://docs.openshift.com/container-platform/4.14/architecture/architecture-rhcos.html

---
[core@hub-ctlplane-0 ~]$ sudo -i
[root@hub-ctlplane-0 /]# podman run --privileged --name perf-container -d quay.io/midu/perf:latest
[root@hub-ctlplane-0 ~]# podman exec -it perf-container /bin/sh
sh-5.2# perf record
```
