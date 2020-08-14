#!/bin/bash
ceph osd pool create volumes
ceph osd pool create images
ceph osd pool create backups
ceph osd pool create vms

rbd pool init volumes
rbd pool init images
rbd pool init backups
rbd pool init vms

ceph auth get-or-create client.glance mon 'profile rbd' osd 'profile rbd pool=images' mgr 'profile rbd pool=images'
ceph auth get-or-create client.cinder mon 'profile rbd' osd 'profile rbd pool=volumes, profile rbd pool=vms, profile rbd-read-only pool=images' mgr 'profile rbd pool=volumes, profile rbd pool=vms'
ceph auth get-or-create client.cinder-backup mon 'profile rbd' osd 'profile rbd pool=backups' mgr 'profile rbd pool=backups'

for i in {1..6}
do
ssh prasta-os$i sudo tee /etc/ceph/ceph.conf </etc/ceph/ceph.conf
done

for i in {1..6}
do
ceph auth get-or-create client.glance | ssh prasta-os$i sudo tee /etc/ceph/ceph.client.glance.keyring
ceph auth get-or-create client.cinder | ssh prasta-os$i sudo tee /etc/ceph/ceph.client.cinder.keyring
ceph auth get-or-create client.cinder-backup | ssh prasta-os$i sudo tee /etc/ceph/ceph.client.cinder-backup.keyring
done