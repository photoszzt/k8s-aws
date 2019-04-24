K8SSTATE=fission-kubernetes-statestore
ZONES=us-east-1a,us-east-1c,us-east-1d
NAME=fission.k8s.local

kops create cluster \
  --cloud aws \
  --name $NAME --state s3://$K8SSTATE \
  --node-count 2 \
  --zones $ZONES \
  --node-size t2.medium \
  --master-size t2.medium \
  --master-zones $ZONES \
  --ssh-public-key ~/.ssh/cluster.pem.pub \
  --networking=canal --yes
