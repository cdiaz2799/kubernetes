## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.25.2 |
| <a name="requirement_onepassword"></a> [onepassword](#requirement\_onepassword) | >= 1.4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.25.2 |
| <a name="provider_onepassword"></a> [onepassword](#provider\_onepassword) | 1.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.gitlab](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.gitlab_agent](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.gitlab_agent_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [onepassword_item.gitlab_access_token](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gitlab_access_token_secret"></a> [gitlab\_access\_token\_secret](#input\_gitlab\_access\_token\_secret) | 1Password Item for GitLab Agent Access Token | `string` | `"Gitlab Agent Access Token"` | no |
| <a name="input_op_vault"></a> [op\_vault](#input\_op\_vault) | Name of 1Password Vault | `string` | n/a | yes |

## Outputs

No outputs.
