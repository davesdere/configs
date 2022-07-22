#kafka.md  
# [Learn Kafka in K8s](https://learnk8s.io/kafka-ha-kubernetes)  
## Translation for KinD  
```kafka-cluster.yml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: kafka-dev-01

nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 31000
    hostPort: 31000
    protocol: TCP
  kubeadmConfigPatches:
  - |
    kind: JoinConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "k8s-role=k8s-control-plane-1"
- role: worker
  kubeadmConfigPatches:
  - |
    kind: JoinConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "k8s-role=k8s-worker-1"
- role: worker
  kubeadmConfigPatches:
  - |
    kind: JoinConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "k8s-role=k8s-worker-2"
- role: worker
  kubeadmConfigPatches:
  - |
    kind: JoinConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "k8s-role=k8s-worker-3"
  extraPortMappings:
  - containerPort: 81
    hostPort: 81
    # optional: set the bind address on the host
    # 0.0.0.0 is the current default
    listenAddress: "127.0.0.3"
    # optional: set the protocol to one of TCP, UDP, SCTP.
    # TCP is the default
    protocol: TCP

```
Deploy cluster  
```
kind create cluster --config=kafka-cluster.yml --name kafka-dev
```
