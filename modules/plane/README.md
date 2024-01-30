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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.plane](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.plane](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_ingress"></a> [app\_ingress](#input\_app\_ingress) | Plane's primary ingress | `string` | n/a | yes |
| <a name="input_cluster_storage_class"></a> [cluster\_storage\_class](#input\_cluster\_storage\_class) | Storage Class | `string` | `"nfs-csi"` | no |
| <a name="input_minio_ingress"></a> [minio\_ingress](#input\_minio\_ingress) | (Optional) Required to open minio console interface | `string` | `null` | no |
| <a name="input_smtp_from"></a> [smtp\_from](#input\_smtp\_from) | SMTP From Address | `string` | n/a | yes |
| <a name="input_smtp_host"></a> [smtp\_host](#input\_smtp\_host) | SMTP Host | `string` | n/a | yes |
| <a name="input_smtp_password"></a> [smtp\_password](#input\_smtp\_password) | SMTP Password | `string` | n/a | yes |
| <a name="input_smtp_port"></a> [smtp\_port](#input\_smtp\_port) | SMTP Port | `number` | `587` | no |
| <a name="input_smtp_ssl_enabled"></a> [smtp\_ssl\_enabled](#input\_smtp\_ssl\_enabled) | SMTP SSL Enabled (1 - enabled; 0 - disabled) | `number` | `0` | no |
| <a name="input_smtp_tls_enabled"></a> [smtp\_tls\_enabled](#input\_smtp\_tls\_enabled) | SMTP TLS Enabled (1 - enabled; 0 - disabled) | `number` | `1` | no |
| <a name="input_smtp_user"></a> [smtp\_user](#input\_smtp\_user) | SMTP Username | `string` | n/a | yes |

## Outputs

No outputs.
