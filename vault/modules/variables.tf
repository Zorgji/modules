variable "create_mountpath" {
  default     = true
  type        = bool
  description = "Enable KV-V2 secret engine path"
}

variable "vault_mount" {
  type = map(object({
    path        = string
    type        = string
    description = string
  }))
  default = {
    "key" = {
      description = "value"
      path        = "value"
      type        = "value"
    }
  }
  description = "KV-V2 secret engine path"
}

variable "create_userpass" {
  default     = false
  type        = bool
  description = "Authenticate with Username/Password"
}

variable "users_path" {
  type = map(object({
    path      = string
    data_json = any
  }))
  default = {
    "user" = {
      data_json = <<EOT
      {
        "policies": ["reader"],
        "password": "reader"
      }
      EOT
      path      = "auth/userpass/users/reader"
    }
  }
  description = ""
}


variable "create_generic_secret" {
  default     = true
  type        = bool
  description = "Enable Generic Secrets or not"
}

variable "generic_secret" {
  type = map(object({
    path                = string
    disable_read        = bool
    delete_all_versions = bool
    data_json           = any
  }))
  default = {
    "key1" = {
      data_json           = <<EOF
      { "key1" : "value1" }
      EOF
      delete_all_versions = false
      disable_read        = false
      path                = "default1"
    },
    "key2" = {
      data_json           = <<EOF
      { "key2" : "value2" }
      EOF
      delete_all_versions = false
      disable_read        = false
      path                = "default2"
    },
  }
  description = "Key/Value store"
}

variable "create_policy" {
  type        = bool
  default     = true
  description = "Enable Vault policy or not"
}

variable "vault_policy" {
  type = map(object({
    name   = string
    policy = any
  }))
  default = {
    "key" = {
      name   = "default"
      policy = <<EOF
      ## Policy Sample
      path "default/data/*"
      {
          capabilities = ["read"]
      }
      EOF
    }
  }
  description = "Policy to read secret by path"
}


## ASSUMED ROLE
variable "create_aws_auth_backend" {
  default     = false
  type        = bool
  description = "Enable AWS Auth method or not"
}

variable "aws_auth_path" {
  type        = string
  default     = ""
  description = "AWS Authentication Methods path"
}

variable "create_aws_secret_backend" {
  default     = false
  type        = bool
  description = "Enable AWS Secret Backend or not for Vault"
}

variable "access_key" {
  type        = string
  default     = "value"
  description = "AWS Assumed Role access key"
}

variable "secret_key" {
  type        = string
  default     = "value"
  description = "AWS Assumed Role secret key"
}

variable "default_ttl" {
  type        = number
  default     = 2700
  description = "Default Time To Live for Assumed role"
}

variable "max_ttl" {
  type        = number
  default     = 3600
  description = "Maximum Time To Live for Assumed role"
}

variable "aws_secret_path" {
  type        = string
  default     = ""
  description = "AWS Secret Engine path for Assumed Role"
}

variable "create_auth_backend_role" {
  type        = bool
  default     = false
  description = "Enable STS role or not for Vault"
}

variable "auth_backend_role" {
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  default = {
    "key" = {
      account_id = 123123123123
      sts_role   = "ROLE_ARN"
    }
  }
  description = "Role that will be used by Vault authenticating AWS"
}

variable "create_secret_backend_role" {
  type        = bool
  default     = false
  description = "Enable a role on an AWS Secret Backend or not for Vault"
}

variable "secret_backend_role" {
  type = map(object({
    name      = string
    role_arns = list(string)
  }))
  default = {
    "key" = {
      name      = "default"
      role_arns = ["ROLE_ARN"]
    }
  }
  description = "Create and use STS Assumed Role by Vault performing necessary actions respectively"
}

variable "credential_type" {
  type        = string
  default     = "assumed_role"
  description = "AWS STS Assumed Role type"
}

variable "region" {
  default     = "us-east-1"
  type        = string
  description = "Region that Vault residing"
}


## IAM User
variable "create_aws_auth_backend_user" {
  type        = bool
  default     = true
  description = "Enable AWS Auth method or not"
}

variable "aws_auth_path_user" {
  type        = string
  default     = "value"
  description = "AWS Authentication Methods path"
}

variable "create_aws_secret_backend_user" {
  type        = bool
  default     = false
  description = "Enable AWS Secret Backend or not for Vault"
}

variable "access_key_user" {
  type        = string
  default     = "value"
  description = "AWS access key"
}

variable "secret_key_user" {
  type        = string
  default     = "value"
  description = "AWS secret key"
}

variable "default_ttl_user" {
  type        = number
  default     = 2700
  description = "Default Time To Live"
}

variable "max_ttl_user" {
  type        = number
  default     = 3600
  description = "Maximum Time To Live"
}

variable "aws_secret_path_user" {
  type        = string
  default     = ""
  description = "AWS Secret engine path for IAM User"
}

variable "region_user" {
  type        = string
  default     = "us-east-1"
  description = "Region that Vault residing"
}

variable "create_auth_backend_role_user" {
  type        = bool
  default     = false
  description = "Enable STS role or not on Vault"
}

variable "auth_backend_role_user" {
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  default = {
    "key" = {
      account_id = 123123123123
      sts_role   = "ROLE_ARN"
    }
  }
  description = "If enabled, This Role that will be used by Vault authenticating and performing necessary actions"
}

variable "create_secret_backend_role_user" {
  type        = bool
  default     = false
  description = "Enable a role on an AWS Secret Backend for Vault"
}

variable "secret_backend_role_user" {
  type = map(object({
    name            = string
    policy_document = any
  }))
  default = {
    "ec2" = {
      name            = "ec2-user"
      policy_document = <<EOT
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
          }
        ]
      }
      EOT
    }
  }
  description = "IAM User with defined IAM permission policy respectively"
}

variable "credential_type_user" {
  type        = string
  default     = "iam_user"
  description = "AWS IAM User type"
}


## JWT
variable "enabled_jwt_backend" {
  type        = bool
  default     = false
  description = "Enable JWT Auth Backend or not"
}

variable "jwt_path" {
  type        = string
  default     = "default"
  description = "JWT Authentication path"
}

variable "bound_issuer" {
  type        = string
  default     = ""
  description = "The value against which to match the iss claim in a JWT"
}

variable "create_acc_role" {
  type        = bool
  default     = false
  description = "Enable Account JWT Auth Backend Role or not"
}

variable "acc_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  default = {
    "key" = {
      bound_claims = {
        "key" = "value"
      }
      role_name = "value"
    }
  }
  description = "JWT/OIDC auth backend role for AWS Account in a Vault server"
}

variable "acc_token_policies" {
  type        = list(string)
  default     = [""]
  description = "AWS Accounts policy name"
}

variable "create_secret_role" {
  type        = bool
  default     = false
  description = "Enable Secrets JWT Auth Backend Role or not"
}

variable "secret_bound_claims" {
  type = map(object({
    role_name    = string
    bound_claims = map(string)
  }))
  default = {
    "key" = {
      bound_claims = {
        "key" = "value"
      }
      role_name = "value"
    }
  }
  description = "JWT/OIDC auth backend role for Secrets values in a Vault server"
}

variable "secret_token_policies" {
  type        = list(string)
  default     = ["value"]
  description = "Secrets policy name"
}

