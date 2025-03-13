# Replicator [#04076665](https://access.redhat.com/support/cases/#/case/04076665/)

## Table of Contents

- [Replicator #04076665](#replicator-04076665)
  - [Table of Contents](#table-of-contents)
  - [Environment](#environment)
  - [Building the perf OCI](#building-the-perf-oci)
    - [Step 1: Build the `perf` image](#step-1-build-the-perf-image)
    - [Step 2: Build the `iperf3` image](#step-2-build-the-iperf3-image)
    - [Step 3: Build the `tcpdump` image](#step-3-build-the-tcpdump-image)
  - [Running the Replicator Deployment](#running-the-replicator-deployment)
    - [Step 1: Create the replicator deployment](#step-1-create-the-replicator-deployment)
    - [Step 2: Verify the deployment](#step-2-verify-the-deployment)
    - [Step 3: Collect `perf` data](#step-3-collect-perf-data)
  - [Conclusions and Results](#conclusions-and-results)

## Environment

- **OCP**: 4.14.35
- **MultiNodeOpenShift** 
- **Kernel version**: 5.14.0-284.79.1.el9_2.x86_64

## Building the perf OCI

To build the required OCI images, you can follow these steps:

### Step 1: Build the `perf` image

```bash
midu$ make all
podman build -t quay.io/midu/perf:latest ./perf
```

**Build output**:

```bash
STEP 1/3: FROM fedora:latest
STEP 2/3: RUN dnf install -y perf     && dnf clean all
STEP 3/3: CMD ["sleep", "infinity"]
COMMIT quay.io/midu/perf:latest
Successfully tagged quay.io/midu/perf:latest
Successfully tagged localhost/ubi-perf-image:latest
4579ca151e956e4839a5e963aad668f45d49d08b0c04206d575ad132c8651d41
podman push quay.io/midu/perf:latest
```

### Step 2: Build the `iperf3` image

```bash
podman build -t quay.io/midu/iperf3:latest ./iperf3
```

**Build output**:

```bash
STEP 1/3: FROM fedora:latest
STEP 2/3: RUN dnf install -y iperf3     && dnf clean all
STEP 3/3: CMD ["iperf3", "-s"]
COMMIT quay.io/midu/iperf3:latest
Successfully tagged quay.io/midu/iperf3:latest
```

### Step 3: Build the `tcpdump` image

```bash
podman build -t quay.io/midu/tcpdump:latest ./tcpdump
```

**Build output**:

```bash
STEP 1/3: FROM fedora:latest
STEP 2/3: RUN dnf install -y tcpdump     && dnf clean all
STEP 3/3: CMD ["tcpdump", "-i", "any", "-n"]
COMMIT quay.io/midu/tcpdump:latest
Successfully tagged quay.io/midu/tcpdump:latest
```

> **Note**: The `Makefile` can be used in case you do not want to use the pre-built images available here:
> - `quay.io/midu/tcpdump:golang-sockets`
> - `quay.io/midu/iperf3:latest`
> - `quay.io/midu/perf:latest`

## Running the Replicator Deployment

Before proceeding, ensure to update the `replicator.yaml` deployment file to match your environment. The section that requires an update is outlined by the `Specify the exact node name here` note.

### Step 1: Create the replicator deployment

```bash
[root@INBACRNRDL0102 ~]# oc create -f replicator.yaml
```

### Step 2: Verify the deployment

You can check the created resources using the following commands:

- **Pods**:

  ```bash
  [root@INBACRNRDL0102 ~]# oc get pods -n 04076665
  NAME                              READY   STATUS    RESTARTS        AGE
  iperf-test-584b594cb9-qf465       2/2     Running   6 (3m24s ago)   13m
  tcpdump-stress-7cf4ccf65f-jh8mh   1/1     Running   0               13m
  ```

- **ReplicaSets**:

  ```bash
  [root@INBACRNRDL0102 ~]# oc get rs -n 04076665
  NAME                        DESIRED   CURRENT   READY   AGE
  iperf-test-584b594cb9       1         1         1       14m
  tcpdump-stress-7cf4ccf65f   1         1         1       14m
  ```

- **Deployments**:

  ```bash
  [root@INBACRNRDL0102 ~]# oc get deployments -n 04076665
  NAME             READY   UP-TO-DATE   AVAILABLE   AGE
  iperf-test       1/1     1            1           17m
  tcpdump-stress   1/1     1            1           17m
  ```

> **Note**: When the `tcpdump-stress` pod is running, it will generate 1000 sockets in batches of 50 as follows:

```bash
midu@midu-thinkpadp16vgen1:~$ sudo podman run --rm --privileged --network host quay.io/midu/tcpdump:golang-sockets
[sudo] password for midu: 
Trying to pull quay.io/midu/tcpdump:golang-sockets...
Getting image source signatures
Copying blob adc19480d756 done   | 
Copying blob dd208f11de02 done   | 
Copying blob c84f6818dc2b done   | 
Copying blob 5961fac199ad done   | 
Copying config 5a1d69ec6c done   | 
Writing manifest to image destination
Opened 50 sockets so far...
Opened 100 sockets so far...
Opened 150 sockets so far...
...
Opened 1000 sockets so far...
All sockets created successfully!
```

### Step 3: Collect `perf` data

To collect performance data, connect to the node and start the `perf` container:

```bash
[root@INBACRNRDL0102 ~]# ssh hub-ctlplane-0
Red Hat Enterprise Linux CoreOS 414.92.202408100542-0
  Part of OpenShift 4.14, RHCOS is a Kubernetes native operating system
  managed by the Machine Config Operator (`clusteroperator/machine-config`).

WARNING: Direct SSH access to machines is not recommended; instead, make configuration changes via `machineconfig` objects:
  https://docs.openshift.com/container-platform/4.14/architecture/architecture-rhcos.html

[core@hub-ctlplane-0 ~]$ sudo -i
[root@hub-ctlplane-0 /]# podman run --privileged --name perf-container -d quay.io/midu/perf:latest
[root@hub-ctlplane-0 ~]# podman exec -it perf-container /bin/sh
sh-5.2# perf record
```

## Conclusions and Results

TBD