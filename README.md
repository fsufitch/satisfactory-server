# Yet Another Satisfactory Dedicated Server

A container setup for running a dedicated server for the [https://www.satisfactorygame.com/](Satisfactory) video game.

## Usage

The image is hosted on Dockerhub as `docker.io/fsufitch/satisfactory-server`:

```sh
docker pull docker.io/fsufitch/satisfactory-server
```

Using the `latest` tag may result in automatic (and unintended?) updates to your server. If you wish to pin your running version, tags are available based on the version of the game server itself, such as:

* By semantic version `docker.io/fsufitch/satisfactory-server:5.3.2`
* By build number: `docker.io/fsufitch/satisfactory-server:368883`

This image can produce a Satisfactory game server as-is. However, due to the "ephemeral" design of containers. You should volume-mount some paths so you don't lose data on server restart:

* `/home/steam/.config/Epic/FactoryGame` &mdash; This holds your game/world data. For performance, this is best held in an actual volume rather than your host's filesystem.
* `/home/steam/satisfactory/FactoryGame/Saved` &mdash; This holds logs, configurations, and other transient data relevant to the server. This can be mounted to your host filesystem for ease of access.

Some other considerations:

* You should start the container with `--interactive` and `--tty`, as otherwise it may fail to respond to SIGTERM.
* The game exposes ports `7777/tcp` and `7777/udp`. These must be exposed.
* Since the server data is persisted across runtimes by mounting the locations above, you may want to run your server using `--rm`, to avoid littering with old containeres.



As such, a sample command for running the game is:

```sh
docker run \
    --interactive --tty --rm \
    -v "savedata:/home/steam/.config/Epic/FactoryGame" \
    -v "$(pwd)/server-data:/home/steam/satisfactory/FactoryGame/Saved" \
    -p 7777:7777/tcp \
    -p 7777:7777/udp \
    docker.io/fsufitch/satisfactory-server
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
