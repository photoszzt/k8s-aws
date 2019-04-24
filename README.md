# Scripts to setup a local kubernetes cluster in AWS VPC

To use the scripts, first install terraform. Then look at main.tf and see whether there's anything you want to modify.
```
$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply
$ cd ../kubernetes-cluster
$ # before execute the following command, you should modify the public key file name to yours.
$ ./regen-cluster.sh # this script will setup the cluster.

```

To remove the cluster, run
```
kops delete cluster --name ${NAME} --state s3://${bucket-name}
```
