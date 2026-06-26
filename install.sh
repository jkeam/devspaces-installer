#!/bin/bash

set -e

echo "=== Red Hat OpenShift Dev Spaces Installer ==="
echo ""

check_oc_login() {
    echo "Checking OpenShift login status..."
    if ! oc whoami &> /dev/null; then
        echo "Error: Not logged into OpenShift cluster"
        echo "Please run: oc login <cluster-url>"
        exit 1
    fi
    echo "Logged in as: $(oc whoami)"
    echo "Cluster: $(oc whoami --show-server)"
    echo ""
}

check_dsc_installed() {
    echo "Checking OpenShift Dev Spaces status..."
    if dsc server:status; then
        echo "Dev Spaces Cluster is already installed, nothing to do"
        exit 0
    fi
    echo ""
}

patch_checluster() {
    oc patch checluster devspaces -n openshift-devspaces --type merge -p '{"spec": {"devEnvironments": {"maxNumberOfRunningWorkspacesPerCluster": -1}}}'
    oc patch checluster devspaces -n openshift-devspaces --type merge -p '{"spec": {"devEnvironments": {"maxNumberOfRunningWorkspacesPerUser": -1}}}'
    oc patch checluster devspaces -n openshift-devspaces --type merge -p '{"spec": {"devEnvironments": {"maxNumberOfWorkspacesPerUser": -1}}}'
    oc patch checluster devspaces -n openshift-devspaces --type merge -p '{"spec": {"devEnvironments": {"secondsOfInactivityBeforeIdling": -1}}}'
    oc patch checluster devspaces -n openshift-devspaces --type merge -p '{"spec": {"devEnvironments": {"secondsOfRunBeforeIdling": -1}}}'
    oc patch checluster devspaces -n openshift-devspaces --type merge -p '{"spec": {"components": {"pluginRegistry": {"openVSXURL": "https://open-vsx.org"}}}}'
}

main() {
    check_oc_login
    check_dsc_installed
    # install
    dsc server:deploy --platform openshift
    patch_checluster
}

main
