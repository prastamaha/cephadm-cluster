# Cephadm create cluster

## Clone

```
git clone https://github.com/prastamaha/cephadm-cluster.git
cd cephadm-cluster
```

## Prerequisites

```
ansible-playbook -i hosts prerequisites.yml
```

## Install ceph-common on all nodes

```
ansible-playbook -i hosts ceph-common.yml
```

## bootstrap new cluster

```
cephadm bootstrap --apply-spec cephadm-cluster.yml --mon-ip 10.10.150.10
```