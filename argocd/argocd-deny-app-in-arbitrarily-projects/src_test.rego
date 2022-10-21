package argocd.deny_app_in_arbitrarily_projects

test_deny_default {
	input := {
		"apiVersion": "argoproj.io/v1alpha1",
		"kind": "Application",
		"metadata": {"name": "test-app"},
		"spec": {"project": "default"},
		"parameters": {"projects": ["default", "deny"]},
	}

	violation[{"msg": "Error: ArgoCD Application test-app is not permitted to use ArgoCD project [default,deny]."}] with input as input
}

test_deny_deny {
	input := {
		"apiVersion": "argoproj.io/v1alpha1",
		"kind": "Application",
		"metadata": {"name": "test-app"},
		"spec": {"project": "deny"},
		"parameters": {"projects": ["default", "deny"]},
	}

	violation[{"msg": "Error: ArgoCD Application test-app is not permitted to use ArgoCD project [default,deny]."}] with input as input
}

test_not_deny {
	input := {
		"apiVersion": "argoproj.io/v1alpha1",
		"kind": "Application",
		"metadata": {"name": "test-app"},
		"spec": {"project": "not-deny"},
		"parameters": {"projects": ["default", "deny"]},
	}

	not violation[{"msg": "Error: ArgoCD Application test-app is not permitted to use ArgoCD project [default,deny]."}] with input as input
}
