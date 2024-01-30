module "gitlab_agent" {
  source   = "./modules/gitlab_agent"
  op_vault = var.op_vault
}
