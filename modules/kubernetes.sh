kubectl_DescribeLastPod()    { kubectl describe pod "$(kubectl get pods | tail -n +2 | awk '{print $1;}')" "$@" ; }
kubectl_DescribePod()        { kubectl describe pod "$@" ; }
kubectl_GetPods()            { kubectl get pods "$@"; }
kubectl_GetAllPods()         { kubectl get pods --all-namespaces "$@"; }
kubectl_GetSvc()             { kubectl get svc "$@"; }
kubectl_GetDeployments()     { kubectl get deployments "$@"; }
kubectl_GetAllDeployments()  { kubectl get deployments --all-namespaces "$@"; }
kubectl_GetServices()        { kubectl get services "$@"; }
kubectl_GetAllServices()     { kubectl get services --all-namespaces "$@"; }
kubectl_GetIngress()         { kubectl get ingress "$@"; }
kubectl_GetAllIngress()      { kubectl get ingress --all-namespaces "$@"; }
kubectl_GetNodes()           { kubectl get nodes "$@"; }
kubectl_Logs()               { kubectl logs "$@"; }
kubectl_EnterContainerSh()   { kubectl exec -it "$(kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" sh -c "$1" ; }
kubectl_EnterContainerBash() { kubectl exec -it "$(kubectl get pods | tail -n +2 | cut -d' ' -f1 | fzf)" bash -c "$1" ; }
