#!/usr/bin/env bash

kube_ctx() {
	ctx=$(kubectl config current-context 2> /dev/null)
	if [ -z "$ctx" ]; then
		return
	fi

	namespace=$(kubectl config get-contexts $ctx --no-headers | tr -s ' ' | cut -d' ' -f 5 2> /dev/null)
	if [ ! -n "$namespace" ]; then
		namespace="default"
	fi

	echo " $ctx:$namespace"
}

kube_ctx
