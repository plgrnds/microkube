# Microcube

This project contains minimal Kubernetes ansible-based setup.

## Usage

Update *hosts.ini* with the details of the hosts you want to run Kubernetes cluster on.

```bash
source setup.sh
ansible-playbook -i plgrid.ini playbooks/setup-base.yml
```

## Kubernetes console

To access Kubernetes console install the *kubecfg.p12* certificate which should be created inside *artifacts* directory.
The default credentials are set to test/test.

Login using a bearer token. To get the token run:
```bash
ansible-playbook -i plgrid.ini playbooks/setup-base.yml --tags login
```

Then open your browser at

```bash
https://<your host>:6443/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

## Grafana monitoring

By default grafana monitoring is NOT installed. To install you can issue

```bash
ansible-playbook -i plgrid.ini playbooks/cluster/grafana
```

Then login to a box with port forwarding enabled (3000:localhost:3000) and issue

```bash
kubectl port-forward $(kubectl get  pods --selector=app=kube-prometheus-grafana -n  monitoring --output=jsonpath="{.items..metadata.name}") -n monitoring  3000
```

## Spark

```bash
helm install --name spark stable/spark --set Worker.Cpu=1000m --set Worker.Memory=6G --set Worker.CpuTargetPercentage=100 --set Worker.DaemonMemory=6G --set Worker.ExecutorMemory=6G --set Worker.Replicas=6
```

```bash
helm install incubator/sparkoperator --namespace spark-operator --set createSparkJobNamespace=true --set sparkJobNamespace=test-ns
```

## Useful resources
* [Kubernetes Cheatsheet](https://github.com/dennyzhang/cheatsheet-kubernetes-A4)
* [Kubernetes Resource Templates](https://cheatsheet.dennyzhang.com/cheatsheet-kubernetes-yaml)
* [Flannel network modes](https://github.com/coreos/flannel/blob/master/Documentation/backends.md)
* [Spark K8S Operator](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/blob/master/docs/quick-start-guide.md)
* [Spark Manual Setup](https://github.com/kubernetes/examples/tree/master/staging/spark)