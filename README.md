# OpenShift Dev Spaces Installer

Automated installation script for Red Hat OpenShift Dev Spaces.

## Prerequisites

- OpenShift CLI (`oc`) installed
- Access to an OpenShift cluster (4.10+)
- Cluster admin privileges
- OpenShift Dev Spaces CLI (`dsc`) installed

## Install

### Option 1

```shell
# assumes you are installed as a cluster admin already
./install.sh
```

### Option 2

```shell
# if you are not logged in,
# you can put in the username/password
# in ./login-and-install.sh
./login-and-install.sh
```

## Uninstalling

```shell
./uninstall.sh
```
