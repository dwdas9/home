---
layout: default
title: Entry Point | CMD
parent: Docker
nav_order: 4
---

## Understanding Dockerfile CMD and ENTRYPOINT Instructions

CMD and ENTRYPOINT are crucial Dockerfile instructions that define what command runs when a Docker container starts. Here, I will try to explain the concepts:
### What is ENTRYPOINT?

ENTRYPOINT sets the main process that will run inside the container. For example:
```dockerfile
ENTRYPOINT ["/usr/bin/my-app"]
```
In this case, `/usr/bin/my-app` is the process that will run when the container starts.

### What is CMD?

CMD specifies the default arguments for the ENTRYPOINT process. For instance:
```dockerfile
ENTRYPOINT ["/usr/bin/my-app"]
CMD ["help"]
```
Here, `help` is passed as an argument to `/usr/bin/my-app`.

### Key Differences Between ENTRYPOINT and CMD

- **ENTRYPOINT**: Defines the main process to run in the container.
- **CMD**: Provides default arguments for the ENTRYPOINT process.
- **Override**:
  - CMD can be easily overridden by passing arguments in the `docker run` command.
  - ENTRYPOINT can be changed using the `--entrypoint` flag in `docker run`, but this is rarely necessary.

### Examples

#### Example 1: Using ENTRYPOINT

```dockerfile
FROM alpine:latest
ENTRYPOINT ["ls"]
```
Build and run:
```bash
$ docker build -t entrypoint-demo .
$ docker run entrypoint-demo
```
This runs the `ls` command in the container.

#### Example 2: Using CMD

```dockerfile
FROM alpine:latest
CMD ["ls"]
```
Build and run:
```bash
$ docker build -t cmd-demo .
$ docker run cmd-demo
```
This runs `ls` using the default shell (`/bin/sh -c`).

#### Example 3: Using ENTRYPOINT and CMD Together

```dockerfile
FROM alpine:latest
ENTRYPOINT ["ls"]
CMD ["-alh"]
```
Build and run:
```bash
$ docker build -t entrypoint-cmd-demo .
$ docker run entrypoint-cmd-demo
```
This runs `ls -alh` in the container.

### Conclusion

ENTRYPOINT sets the process to run, while CMD sets the default arguments. Use ENTRYPOINT for the main application and CMD for default arguments to make Docker images flexible and user-friendly.