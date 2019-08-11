#!/usr/bin/env bash
# (requires docker, docker-compose)
# shellcheck disable=SC2046

docker_stopAllContainers() { sudo docker stop $(sudo docker ps -q); }
docker_stopAllContainersNonGracefully() { sudo docker kill $(sudo docker ps -q); }
docker_deleteComposeVolumes() { sudo docker-compose down -v ; }
docker_showLatestCreatedContainer() { sudo docker ps -a --latest; }
docker_getLatestCreatedContainerId() { sudo docker ps -a --latest -q; }
docker_startLatestCreatedContainer() { sudo docker start "$(sudo docker ps -a --latest -q)" ;}

docker_listContainers() { sudo docker ps -a ; }
docker_listRunningContainers() { sudo docker ps; }
docker_listRunningContainerIps() { sudo docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(sudo docker ps -q) ; }
docker_enterContainerBash() { sudo docker exec -it "$(sudo docker ps --format "{{.Names}}" | fzf | cat)" /bin/bash ; }
docker_enterContainerSh() { sudo docker exec -it "$(sudo docker ps --format "{{.Names}}" | fzf | cat)" /bin/sh ; }
docker_runCommandInContainer() { sudo docker exec -it "$@"; }
docker_runCommandInContainerWithContainerPrompt() { sudo docker exec -it "$(docker_promptForRunningContainer)" "$@"; }
docker_promptForRunningContainer() { sudo docker ps --format "{{.Names}}" | fzf ; }

docker_dockerComposeUp() { sudo docker-compose up ; }
docker_dockerComposeStop() { sudo docker-compose stop ; }

docker_getImageHash_sha256() { sudo docker inspect --format='{{index .RepoDigests 0}}' "$@";}

