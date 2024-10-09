# Yet Another Satisfactory Dedicated Server

A container setup for running a dedicated server for the [https://www.satisfactorygame.com/](Satisfactory) video game.

## Usage

The image is hosted on Dockerhub as `docker.io/fsufitch/satisfactory-server`:

```sh
docker pull docker.io/fsufitch/satisfactory-server
```


## Development

To build the image, use the included `ci.sh` utility:

```sh
$ ./ci.sh
...
Successfully tagged docker.io/fsufitch/satisfactory-server:latest
d70009b502b600a1273ff9d4c9b8feab8269a2a41be12fabbe7fb6d53e1ddf7c
+ /usr/bin/podman tag docker.io/fsufitch/satisfactory-server:latest docker.io/fsufitch/satisfactory-server:5.3.2
+ /usr/bin/podman tag docker.io/fsufitch/satisfactory-server:latest docker.io/fsufitch/satisfactory-server:368883
```

The utility can be configured via environment variables.

| Variable | Default | Purpose |
| --- | --- | --- |
| `BUILD_REPOSITORY` | `docker.io/fsufitch/satisfactory-server` | "Name" of the built image, for later usage or pushing |
| `BUILD_VERSION` | `latest` | Version to be added to the repository name from above |
| `SKIP_TAGGING` | (unset) | Set to **not** create additional tags based on the version of Satisfactory inside the image |
| `ENABLE_PUSH` | (unset) | Set to enable pushing/publishing the built image | 
