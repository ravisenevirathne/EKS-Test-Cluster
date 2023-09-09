#### This terraform code will create a simple Kubernetes cluster on AWS using AWS VPC & EKS modules

To connect the cluster to local pc kubeconfig
```
aws eks update-kubeconfig --name test-eks-clusters
```

Create simple nginx deployment and service to test the cluster
```
kubectl create deployment nginx --image=nginx --replicas=3
kubectl expose deployment nginx --type=LoadBalancer --port=80 --target-port=80

ravi@Ravis-MacBook-Pro-2 EKS-Test-Cluster % kubectl get deployments,pods,services
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   3/3     3            3           76m

NAME                        READY   STATUS    RESTARTS   AGE
pod/nginx-8f458dc5b-h2f89   1/1     Running   0          76m
pod/nginx-8f458dc5b-kk8v2   1/1     Running   0          76m
pod/nginx-8f458dc5b-mbp46   1/1     Running   0          76m

NAME                 TYPE           CLUSTER-IP     EXTERNAL-IP                                                              PORT(S)        AGE
service/kubernetes   ClusterIP      172.20.0.1     <none>                                                                   443/TCP        107m
service/nginx        LoadBalancer   172.20.22.26   a5096f6759b1a4ee3a68e4b8d17f89b2-416497357.us-east-1.elb.amazonaws.com   80:30345/TCP   10m
```

You can test the nginx page using Load balancer DNS url