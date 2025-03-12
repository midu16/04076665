# Replicator

## Environment

OCP 4.14.35
MultiNodeOpenShift 

## Building the perf OCI:

```bash
midu$ make
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
```

> [!NOTE]
> The Makefile can be used in the situation the user doesnt want to use the already build images available here:
> - quay.io/midu/tcpdump:latest
> - quay.io/midu/iperf3:latest
> - quay.io/midu/perf:latest


## Running the Deployment:
- Label one of the node:

```bash
oc label node hub-ctlplane-0.5g-deployment.lab test=true
```

- Connect to the node:

```bash
[root@INBACRNRDL0102 ~]# kcli ssh hub-ctlplane-0
Red Hat Enterprise Linux CoreOS 414.92.202408100542-0
  Part of OpenShift 4.14, RHCOS is a Kubernetes native operating system
  managed by the Machine Config Operator (`clusteroperator/machine-config`).

WARNING: Direct SSH access to machines is not recommended; instead,
make configuration changes via `machineconfig` objects:
  https://docs.openshift.com/container-platform/4.14/architecture/architecture-rhcos.html

---
[core@hub-ctlplane-0 ~]$ sudo toolbox
Trying to pull registry.redhat.io/rhel9/support-tools:latest...
Getting image source signatures
Checking if image destination supports signatures
Copying blob fc48fe9ffe43 done  
Copying blob bb434c7d1523 done  
Copying blob 93a998a4d4a7 done  
Copying blob e40ecead891c done  
Copying config f8ef8c8a7f done  
Writing manifest to image destination
Storing signatures
f8ef8c8a7f7bfadac23fb581ac4f5f22ea7cd386fbe6794c07342ace980edd53
Spawning a container 'toolbox-root' with image 'registry.redhat.io/rhel9/support-tools'
Detected RUN label in the container image. Using that as the default...
9bda4bbfad1fcad01ff6b81a1d148b062e63e5751406bd0ff92a4d8616df4270
toolbox-root
Container started successfully. To exit, type 'exit'.
[root@hub-ctlplane-0 /]# podman run --privileged --name perf-container --entrypoint "perf stat -e cycles,instructions,cache-references,cache-misses sleep 10" -d quay.io/midu/perf:latest
```
