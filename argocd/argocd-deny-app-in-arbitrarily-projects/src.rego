# METADATA
# title: Deny ArgoCD application deployed in arbitrarily projects
# description: |-
#   Deny ArgoCD application deployed in arbitrarily projects.
# custom:
#   matchers:
#     kinds:
#     - kinds:
#       - Application
#       apiGroups:
#       - "argoproj.io"
#   parameters:
#     projects:
#       type: array
#       description: Array of deny projects.
#       items:
#         type: string

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
