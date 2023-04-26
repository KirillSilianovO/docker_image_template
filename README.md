# DOCKER IMAGE BUILD TEMPLATE

## Description
Template for building docker images.

## Usage

### Before start
1. Set your image name in Makefile
2. Configure your Dockerfile
3. Configure your .dockerignore

### Build image for architecture
#### ARM64v8

```
make build_arm IMAGE_VERSION=0.0.1
```

#### AMD64

```
make build_amd IMAGE_VERSION=0.0.1
```

### Build and push image

```
make build_push IMAGE_VERSION=0.0.1
```

### CI\CD
For build images you must set version tag