resource "vault_mount" "this" {
  for_each    = { for k, v in var.vault_mount : k => v if var.create_mountpath }
  path        = each.value.path
  type        = each.value.type
  description = each.value.description
}

resource "vault_generic_secret" "this" {
  for_each            = { for k, v in var.generic_secret : k => v if var.create_generic_secret }
  path                = each.value.path
  data_json           = each.value.data_json
  disable_read        = var.disable_read
  delete_all_versions = var.delete_all_versions

  depends_on = [
    vault_mount.this
  ]
}

resource "vault_policy" "this" {
  for_each = { for k, v in var.vault_policy : k => v if var.create_policy }
  name     = each.value.name
  policy   = each.value.policy
}

## AWS
resource "vault_auth_backend" "this" {
  count       = var.create_aws_auth_backend ? 1 : 0
  type        = "aws"
  path        = var.aws_auth_path
  description = "AWS Auth Backend for GitLab CI/CD"
}

resource "vault_aws_secret_backend" "this" {
  count                     = var.create_aws_secret_backend ? 1 : 0
  description               = "AWS secret engine for Gitlab pipeline!"
  access_key                = var.access_key
  secret_key                = var.secret_key
  default_lease_ttl_seconds = 1800
  max_lease_ttl_seconds     = 7200
  path                      = var.aws_secret_path
  region                    = var.region
}

resource "vault_aws_auth_backend_sts_role" "this" {
  for_each   = { for k, v in var.auth_backend_role : k => v if var.create_auth_backend_role }
  backend    = try(element(vault_auth_backend.this.*.path, 0), "")
  account_id = each.value.account_id
  sts_role   = each.value.sts_role
}
resource "vault_aws_secret_backend_role" "this" {
  for_each        = { for k, v in var.secret_backend_role : k => v if var.create_secret_backend_role }
  backend         = try(element(vault_aws_secret_backend.this.*.path, 0), "")
  name            = each.value.name
  credential_type = var.credential_type
  role_arns       = each.value.role_arns
}

## IAM USER
# resource "vault_aws_secret_backend_role" "user" {
#   for_each        = var.user_backend_role
#   backend         = element(vault_auth_backend.this.*.path, 0)
#   name            = each.value.name
#   credential_type = var.credential_type_user
#   policy_document = each.value.policy_document
# }

## JWT
resource "vault_jwt_auth_backend" "this" {
  count        = var.enabled_jwt_backend ? 1 : 0
  description  = "JWT Auth backend for GitLab CI/CD"
  path         = var.jwt_path
  bound_issuer = var.bound_issuer
  jwks_url     = "https://gitlab.com/-/jwks"
}

resource "vault_jwt_auth_backend_role" "account" {
  for_each          = { for k, v in var.acc_bound_claims : k => v if var.create_acc_role }
  backend           = try(element(vault_jwt_auth_backend.this.*.path, 0), "")
  role_name         = var.acc_role_name
  token_policies    = var.acc_token_policies
  bound_claims_type = "glob"
  user_claim        = "user_email"
  role_type         = "jwt"
  bound_claims      = each.value
}

resource "vault_jwt_auth_backend_role" "secret" {
  for_each          = { for k, v in var.secret_bound_claims : k => v if var.create_secret_role }
  backend           = try(element(vault_jwt_auth_backend.this.*.path, 0), "")
  role_name         = var.secret_role_name
  token_policies    = var.secret_token_policies
  bound_claims_type = "glob"
  user_claim        = "user_email"
  role_type         = "jwt"
  bound_claims      = each.value
}










