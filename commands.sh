stopAllDockerContainers() { sudo docker stop `sudo docker ps -q`}
listRunningDockerContainers() { sudo docker ps}
makeFilePermissionExecutable() { chmod +x $1 }
cdGitProjectRoot() { cd `git rev-parse --show-toplevel` }
