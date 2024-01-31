## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | >= 4.23.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.12.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.25.2 |
| <a name="requirement_onepassword"></a> [onepassword](#requirement\_onepassword) | >= 1.4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.25.2 |
| <a name="provider_onepassword"></a> [onepassword](#provider\_onepassword) | 1.4.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudflared_tunnel"></a> [cloudflared\_tunnel](#module\_cloudflared\_tunnel) | ./modules/cloudflared | n/a |
| <a name="module_gitlab_agent"></a> [gitlab\_agent](#module\_gitlab\_agent) | ./modules/gitlab_agent | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_deployment.eufy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_deployment.homeassistant](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_namespace.home-automation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_persistent_volume_claim.home-automation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/persistent_volume_claim) | resource |
| [kubernetes_secret.eufy_creds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service.eufy](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_service.homeassistant](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [kubernetes_storage_class.nfs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [onepassword_item.cloudflare](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item) | data source |
| [onepassword_item.eufy_creds](https://registry.terraform.io/providers/1Password/onepassword/latest/docs/data-sources/item) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gitlab_access_token"></a> [gitlab\_access\_token](#input\_gitlab\_access\_token) | GitLab Agent Access Token | `string` | n/a | yes |
| <a name="input_home_assistant_version"></a> [home\_assistant\_version](#input\_home\_assistant\_version) | Tag for Home Asisstant Image | `string` | `"stable"` | no |
| <a name="input_op_access_token"></a> [op\_access\_token](#input\_op\_access\_token) | Value of 1Password Access Token | `string` | n/a | yes |
| <a name="input_op_vault"></a> [op\_vault](#input\_op\_vault) | Name of 1Password Vault | `string` | n/a | yes |
| <a name="input_plane_ingress"></a> [plane\_ingress](#input\_plane\_ingress) | Plane Ingress | `string` | `"plane.cdiaz.cloud"` | no |

## Outputs

No outputs.
