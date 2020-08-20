# Cephadm create cluster

## Clone

```
git clone https://github.com/prastamaha/cephadm-cluster.git
cd cephadm-cluster
```

## SSH config
```
nano ~/.ssh/config
```
```
Host *
    UserKnownHostsFile /dev/null
    StrictHostKeyChecking no
    IdentitiesOnly yes
    ConnectTimeout 0
    ServerAliveInterval 300
```

## Prerequisites

```
ansible-playbook -i hosts prerequisites.yml
```

## Install ceph-common on all nodes (optional)

```
ansible-playbook -i hosts ceph-common.yml
```

## bootstrap new cluster

```
cephadm bootstrap --apply-spec cephadm-cluster.yml --mon-ip 10.10.150.10
```
or

```
./boot-cluster.yml
```

deploying a ceph cluster may take several minutes

## create pool and keyring for openstack
```
./openstack-keyring.sh
```


