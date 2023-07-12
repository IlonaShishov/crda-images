# crda-images

This project provides all nessesary components to generate images for Red Hat CodeReady Dependency Analytics. 
These images can be used as base images to set up the necessary environment and dependencies for running the Red Hat CodeReady Dependency Analytics.

## Prerequisites
Before getting started, ensure that you have one of the following prerequisites installed on your system:

- Docker: [Installation Guide](https://docs.docker.com/get-docker/)
- Podman: [Installation Guide](https://podman.io/docs/installation)

Both Docker and Podman are container runtimes that can be used to build and run the CodeReady Dependency Analytics images. You can choose either Docker or Podman based on your preference and the compatibility with your operating system.

## Images generated for CRDA 1.0 

Ecosystem     | Version       | IMAGE                                     | TAG               | 
------------- | ------------- | ------------------------------------------|-------------------|
python        | python3.8     |  crda-python                              | 3.8               |
python        | python3.6     |  crda-python                              | 3.6               |
python        | python3.7     |  crda-python                              | 3.7               | 

## Images generated for CRDA 1.5 

Ecosystem     | Version                                                            | IMAGE                                         | TAG               | 
------------- | ------------------------------------------------------------------ | --------------------------------------------- |-------------------|
All           | maven 3.9.3, <br>golang 1.20.6, <br>python 3.9.16, <br>npm 9.5.0   |  quay.io/ecosystem-appeng/crda-javascript-api | 1.0               |
