# Policies

## Violations

* [Deny ArgoCD Application deployed in the default project](#deny-argocd-application-deployed-in-the-default-project)
* [Deny ArgoCD application deployed in arbitrarily projects](#deny-argocd-application-deployed-in-arbitrarily-projects)

## Deny ArgoCD Application deployed in the default project

**Severity:** Violation

**Resources:** argoproj.io/Application

Deny ArgoCD application deployed in the default project.

### Rego

```rego
package argocd.deny_app_in_default_project

import data.lib.core

violation[{"msg": msg}] {
  name := core.resource.metadata.name
  project := core.resource.spec.project
  project == "default"
  msg := sprintf("Error: %s ArgoCD Application is not permitted to use default ArgoCD project.", [name])
}
```

_source: [argocd/argocd-deny-app-in-default-project](argocd/argocd-deny-app-in-default-project)_

## Deny ArgoCD application deployed in arbitrarily projects

**Severity:** Violation

**Resources:** argoproj.io/Application

**Parameters:**

* projects: array of string
  Array of deny projects.

Deny ArgoCD application deployed in arbitrarily projects.

### Rego

```rego
package argocd.deny_app_in_arbitrarily_projects

import data.lib.core

violation[{"msg": msg}] {
  name := core.resource.metadata.name
  provided := core.resource.spec.project
  denied := {project | project := input.parameters.projects[_]}
  denied_concat := concat(",", denied)
  denied[_] == provided
  msg := sprintf("Error: ArgoCD Application %s is not permitted to use ArgoCD project [%s].", [name, denied_concat])
}
```

_source: [argocd/argocd-deny-app-in-arbitrarily-projects](argocd/argocd-deny-app-in-arbitrarily-projects)_
