# Konstraint examples

## Description

- Examples of [Konstraint](https://github.com/plexsystems/konstraint)

## Prerequirements

- `konstraint`
- `confest`
- `gator`

## Usage

### Generate yaml files for OPA Gatekeeper

1. `konstraint create .`

### Generate documents

1. `konstraint docs .`

### Test `.rego`

1. `conftest verify -p .`
    - For tracing: `conftest verify -p . --trace`
    - For reporting: `conftest verify -p . --report {full|notes|fails}`
1. `opa test . --ignore *.yaml -v`
    - For coverage: `opa test . --ignore *.yaml -v --coverage`

### Gator verify

1. `gator verify path/to/suite.yaml/dir/`

## Scripts

- `./scripts/test-and-run.sh`
  - Run tests by Conftest, OPA, and Gator
  - Generate `constraint.yaml`, `template.yaml`
- `./scripts/kind-with-argocd-and-gatekeeper.sh`
  - Create kind cluster
  - Install ArgoCD
  - Install Gatekeeper
- `./scripts/apply-gatekeeper-constraint.sh`
  - Run `kubectl apply -f constraint.yaml` recursively
  - Run `kubectl apply -f template.yaml` recursively
