package argocd.deny_app_in_default_project

test_violation {
	input := {
		"apiVersion": "argoproj.io/v1alpha1",
		"kind": "Application",
		"metadata": {"name": "test-app"},
		"spec": {"project": "default"},
	}

	violation[{"msg": "Error: test-app ArgoCD Application is not permitted to use default ArgoCD project."}] with input as input
}

test_no_violation {
	input := {
		"apiVersion": "argoproj.io/v1alpha1",
		"kind": "Application",
		"metadata": {"name": "test-app"},
		"spec": {"project": "not-default"},
	}

	not violation[{"msg": "Error: test-app ArgoCD Application is not permitted to use default ArgoCD project."}] with input as input
}
