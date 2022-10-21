# METADATA
# title: Deny ArgoCD Application deployed in the default project
# description: |-
#   Deny ArgoCD application deployed in the default project.
# custom:
#   matchers:
#     kinds:
#     - kinds:
#       - Application
#       apiGroups:
#       - "argoproj.io"
package argocd.deny_app_in_default_project

import data.lib.core

violation[{"msg": msg}] {
	name := core.resource.metadata.name
	project := core.resource.spec.project
	project == "default"
	msg := sprintf("Error: %s ArgoCD Application is not permitted to use default ArgoCD project.", [name])
}
