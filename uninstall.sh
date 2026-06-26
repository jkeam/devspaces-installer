#!/bin/bash

set -e

echo "=== Red Hat OpenShift Dev Spaces Uninstaller ==="
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
    if ! dsc server:status; then
        echo "Dev Spaces Cluster is not installed, nothing to do"
        exit 0
    fi
    echo ""
}

main() {
    check_oc_login
    check_dsc_installed
    dsc server:delete --delete-all
}

main
