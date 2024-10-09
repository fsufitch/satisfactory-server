# Yet Another Satisfactory Dedicated Server

A container setup for running a dedicated server for the [https://www.satisfactorygame.com/](Satisfactory) video game.

To build the image:

```sh
$ ./build.sh
...
Successfully tagged docker.io/fsufitch/satisfactory-server:latest
d70009b502b600a1273ff9d4c9b8feab8269a2a41be12fabbe7fb6d53e1ddf7c
+ /usr/bin/podman tag docker.io/fsufitch/satisfactory-server:latest docker.io/fsufitch/satisfactory-server:5.3.2
+ /usr/bin/podman tag docker.io/fsufitch/satisfactory-server:latest docker.io/fsufitch/satisfactory-server:368883
```

> Use `BUILD_REPOSITORY` and `BUILD_VERSION` to alter the tagged image, or `SKIP_TAGGING` to not create tags based on Satisfactory's game version.
> 
> ```sh
> $ BUILD_REPOSITORY=example.com/foo/bar BUILD_VERSION=123 SKIP_TAGGING=1 ./build.sh
> ...
> Successfully tagged example.com/foo/bar:123
> ```


