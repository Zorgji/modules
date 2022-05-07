variable "region" {
  default     = "us-east-1"
  type        = string
  description = ""
}

variable "create_mountpath" {
  default     = true
  type        = bool
  description = ""
}

variable "vault_mount" {
  type = map(object({
    path        = string
    type        = string
    description = string
  }))
  default     = {}
  description = ""
}

variable "create_generic_secret" {
  default     = true
  type        = bool
  description = ""
}

variable "what" {
  type        = string
  default     = ""
  description = ""
}

variable "generic_secret" {
  type = map(object({
    path      = string
    data_json = any
  }))
  default     = {}
  description = ""
}

variable "vault_auth_backend" {
  type = map(object({
    path        = string
    description = string
  }))
  default     = {}
  description = ""
}

variable "secret_hcl" {
  default     = {}
  type        = any
  description = ""
}

variable "disable_read" {
  default     = false
  type        = bool
  description = ""
}

variable "delete_all_versions" {
  default     = false
  type        = bool
  description = ""
}

variable "create_policy" {
  default     = true
  type        = bool
  description = ""
}

variable "policy_name" {
  default     = ""
  type        = string
  description = ""
}

variable "vault_policy" {
  type = map(object({
    name   = string
    policy = any
  }))
  default     = {}
  description = ""
}

# AWS
variable "create_aws_auth_backend" {
  default     = false
  type        = bool
  description = ""
}

variable "create_aws_secret_backend" {
  default     = false
  type        = bool
  description = ""
}

variable "access_key" {
  default     = ""
  type        = string
  description = ""
}

variable "secret_key" {
  default     = ""
  type        = string
  description = ""
}


variable "create_user_backend_role" {
  type        = bool
  default     = true
  description = ""
}

variable "credential_type_user" {
  default     = "iam_user"
  type        = string
  description = ""
}

variable "user_backend_role" {
  type = map(object({
    name            = string
    policy_document = any
  }))
  default     = {}
  description = ""
}

variable "aws_auth_path" {
  type        = string
  default     = ""
  description = ""
}

variable "aws_secret_path" {
  type        = string
  default     = ""
  description = ""
}

variable "account_id" {
  type        = list(string)
  default     = [""]
  description = ""
}


variable "create_auth_backend_role" {
  type        = bool
  default     = false
  description = ""
}

variable "create_secret_backend_role" {
  type        = bool
  default     = false
  description = ""
}

variable "auth_backend_role" {
  type = map(object({
    account_id = string
    sts_role   = string
  }))
  default     = {}
  description = ""
}

variable "secret_backend_role" {
  type = map(object({
    name      = string
    role_arns = list(string)
  }))
  default     = {}
  description = ""
}

variable "credential_type" {
  default     = "assumed_role"
  type        = string
  description = ""
}

variable "backend_role_name" {
  type        = list(string)
  default     = [""]
  description = ""
}

variable "role_arns" {
  type        = list(string)
  default     = [""]
  description = ""
}

variable "create_sts_role" {
  default     = false
  type        = bool
  description = ""
}



# JWT
variable "enabled_jwt_backend" {
  default     = false
  type        = bool
  description = ""
}

variable "jwt_path" {
  default     = ""
  type        = string
  description = ""
}

variable "create_acc_role" {
  type        = bool
  default     = false
  description = ""
}

variable "create_secret_role" {
  type        = bool
  default     = false
  description = ""
}

variable "bound_issuer" {
  default     = ""
  type        = string
  description = ""
}

variable "acc_role_name" {
  default     = ""
  type        = string
  description = ""
}

variable "acc_token_policies" {
  default     = [""]
  type        = list(string)
  description = ""
}

variable "secret_role_name" {
  default     = ""
  type        = string
  description = ""
}

variable "secret_token_policies" {
  default     = [""]
  type        = list(string)
  description = ""
}

variable "acc_bound_claims" {
  type = map(object({
    project_id = string
    ref        = string
    ref_type   = string
  }))
  default     = {}
  description = ""
}

variable "secret_bound_claims" {
  type = map(object({
    project_id = string
    ref        = string
    ref_type   = string
  }))
  default     = {}
  description = ""
}










































