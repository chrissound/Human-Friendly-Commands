#!/usr/bin/env bash
# (requires docker, docker-compose)
kubectl_describeLastPod()    { kubectl describe pod "$(kubectl get pods --sort-by=.metadata.creationTimestamp | tail -n -1 | awk '{print $1;}')" "$@" ; }
kubectl_describePod()        { kubectl describe pod "$@" ; }
kubectl_getPods()            { kubectl get pods "$@"; }
kubectl_getAllPods()         { kubectl get pods --all-namespaces "$@"; }


kubectl_getDeployments()     { kubectl get deployments "$@"; }
kubectl_getAllDeployments()  { kubectl get deployments --all-namespaces "$@"; }

kubectl_describeService()    { kubectl describe service "$@"; }
kubectl_getServices()        { kubectl get services "$@"; }
kubectl_getAllServices()     { kubectl get services --all-namespaces "$@"; }

kubectl_describeIngress()    { kubectl describe ingress "$@"; }
kubectl_getIngress()         { kubectl get ingress "$@"; }
kubectl_getAllIngress()      { kubectl get ingress --all-namespaces "$@"; }

kubectl_getNodes()           { kubectl get nodes "$@"; }
kubectl_describeNode()        { kubectl describe node "$@" ; }

kubectl_logs()               { kubectl logs "$@"; }
kubectl_enterContainerSh()   { kubectl exec -it "$(kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" sh -c "$1" ; }
kubectl_enterContainerBash() { kubectl exec -it "$(kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" bash -c "$1" ; }

kubectl_create_byFile()           { kubectl create -f "$@"; }
kubectl_apply_byFile()           { kubectl apply -f "$@"; }
kubectl_replace_byFile()           { kubectl replace -f "$@"; }
kubectl_delete_byFile()           { kubectl delete -f "$@"; }

kubectl_getAll() {
  kubectl get nodes "$@"
  kubectl get deployments "$@"
  kubectl get daemonsets "$@"
  kubectl get pods "$@"
  kubectl get rs "$@"
  kubectl get services  "$@"
  kubectl get ingress "$@"
  kubectl get secrets "$@"
  kubectl get serviceaccounts "$@"
}
