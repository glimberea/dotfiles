#!/usr/bin/env bash

kube_ctx() {
	ctx=$(kubectl config current-context 2> /dev/null)
	if [ -z "$ctx" ]; then
		return
	fi

	namespace=$(kubectl config get-contexts $ctx --no-headers | tr -s ' ' | cut -d' ' -f 5 2> /dev/null)
	if [ ! -n "$namespace" ]; then
		echo $namespace
		namespace="default"
	fi

	echo "#[fg=$1] #[fg=$2]$ctx:$namespace"
}

kube_ctx "$@"
