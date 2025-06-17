#!/bin/bash

# Force remove a namespace
# Usage: ./force-remove-namespace.sh <namespace>

NAMESPACE=${1}

if [ -z "${NAMESPACE}" ]; then
    echo "Usage: ./force-remove-namespace.sh <namespace>"
    exit 1
fi

kubectl get namespace "${NAMESPACE}" -o json \
  | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
  | kubectl replace --raw /api/v1/namespaces/"${NAMESPACE}"/finalize -f -