#!/bin/bash

set -eu

## Apply templates
dirs=`find . -type f -name 'template.yaml' | sed -r 's|/[^/]+$||' |sort |uniq`
for dir in ${dirs[@]}; do
    echo $dir
    kubectl apply -f "${dir}/template.yaml"
done

## Apply constraints
dirs=`find . -type f -name 'constraint.yaml' | sed -r 's|/[^/]+$||' |sort |uniq`
for dir in ${dirs[@]}; do
    echo $dir
    kubectl apply -f "${dir}/constraint.yaml"
done
