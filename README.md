# Microcube

This project contains minimal Kubernetes ansible-based setup.

## Usage

Update *hosts.ini* with the details of the hosts you want to run Kubernetes cluster on.

```bash
source setup.sh
ansible-playbook -i plgrid.ini cluster.yml
```