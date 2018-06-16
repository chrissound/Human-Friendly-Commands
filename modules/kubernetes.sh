kubectl_DescribeLastPod() { kubectl describe pod "$(kubectl get pods | tail -n +2 | awk '{print $1;}')" "$@" ; }
kubectl_GetPods() { kubectl get pods "$@"; }
kubectl_GetSvc() { kubectl get svc "$@"; }
kubectl_GetDeployments() { kubectl get deployments "$@"; }
kubectl_GetNodes() { kubectl get nodes "$@"; }
kubectl_EnterContainer() { kubectl exec -it "$(kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" sh -c "$1" ; }
