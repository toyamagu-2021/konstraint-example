#!/bin/bash

set -eu

## Conftest
echo "Start Conftest..."
conftest fmt .
conftest verify -p .
echo "End Conftest..."
echo ""

## OPA coverage
echo "Start OPA"
opa test . --ignore *.yaml
OPA_COVERAGE=`opa test . --ignore *.yaml  --coverage -v | jq .coverage`
echo "Test coverage is ${OPA_COVERAGE}"
echo "End OPA"
echo ""

## Konstraint
echo "Start Konstraint..."
konstraint doc .
konstraint create .
echo "End Konstraint..."
echo ""

## Gator
echo "Start Gator..."
dirs=`find . -type f -name 'suite.yaml' | sed -r 's|/[^/]+$||' |sort |uniq`
for dir in ${dirs[@]}; do
    echo "Gator verify dir: $dir"
    gator verify ${dir}
done
echo "End Gator..."
echo ""