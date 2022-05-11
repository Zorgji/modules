variable "vault_addr" {
  type        = string
  default     = ""
  description = "Vault url"
}

variable "token" {
  type        = string
  default     = ""
  description = "Token to manage Vault"
}

## Secrets
variable "create_mountpath" {
  type        = bool
  default     = false
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
      description = "My Secrets"
      path        = "default"
      type        = "kv-v2"
    }
  }
  description = "KV-V2 secret engine path"
}

variable "create_generic_secret" {
  type        = bool
  default     = true
  description = "Enable Generic Secrets or not"
}

variable "generic_secret" {
  type = map(object({
    data_json           = any
    delete_all_versions = bool
    disable_read        = bool
    path                = string
  }))
  default = {
    "key1" = {
      data_json           = <<EOF
      { "key1" : "value1" }
      EOF
      delete_all_versions = false
      disable_read        = false
      path                = "default1/network2"
    },
    "key2" = {
      data_json           = <<EOF
      { "key2" : "value2" }
      EOF
      delete_all_versions = false
      disable_read        = false
      path                = "default2/network2"
    }
  }
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
    "qa" = {
      name   = "network-read-qa"
      policy = <<EOF
      ## Policy for only reading QA secret values
      path "default/data/qa/*"
      {
          capabilities = ["read"]
      }
      EOF
    },
    "uat" = {
      name   = "network-read-uat"
      policy = <<EOF
      ## Policy for only reading UAT secret values
      path "default/data/uat/*"
      {
          capabilities = ["read"]
      }
      EOF
    }
  }
  description = "Policy to read Secrets by path"
}

## Assumed Role
variable "access_key" {
  default     = ""
  type        = string
  description = "AWS access key"
}

variable "secret_key" {
  default     = ""
  type        = string
  description = "AWS secret key"
}

variable "create_aws_auth_backend" {
  default     = false
  type        = bool
  description = "Enable AWS Auth method or not in Vault"
}

variable "create_aws_secret_backend" {
  default     = false
  type        = bool
  description = "Enable AWS Secret Backend or not in Vault"
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

variable "aws_auth_path" {
  type        = string
  default     = ""
  description = "AWS Authentication Methods path"
}

variable "aws_secret_path" {
  type        = string
  default     = ""
  description = "AWS Secret Engine path for Assumed Role"
}

variable "create_auth_backend_role" {
  type        = bool
  default     = true
  description = "Enable STS role or not for Vault"
}

variable "auth_backend_role" {
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  default = {
    "ops" = {
      account_id = 123123123123
      sts_role   = "arn:aws:iam::123123123123:role/automation-role"
    },
    "qa" = {
      account_id = 234234234234
      sts_role   = "arn:aws:iam::234234234234:role/automation-role"
    }
  }
  description = "Role that will be used by Vault authenticating AWS"
}

variable "create_secret_backend_role" {
  type        = bool
  default     = true
  description = "Enable a role on an AWS Secret Backend or not for Vault"
}

variable "secret_backend_role" {
  type = map(object({
    name      = string
    role_arns = list(string)
  }))
  default = {
    "ops" = {
      name      = "ops"
      role_arns = ["arn:aws:iam::533322910785:role/automation-role"]
    },
    "qa" = {
      name      = "qa"
      role_arns = ["arn:aws:iam::328647089605:role/automation-role"]
    },
    "stg" = {
      name      = "stg"
      role_arns = ["arn:aws:iam::193357654123:role/automation-role"]
    }
  }
  description = "If enabled, Create and use STS Assumed Role by Vault performing necessary actions respectively"
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
variable "access_key_user" {
  type        = string
  default     = ""
  description = "AWS access key"
}

variable "secret_key_user" {
  type        = string
  default     = ""
  description = "AWS secrert key"
}

variable "create_aws_auth_backend_user" {
  type        = bool
  default     = true
  description = "Enable AWS Auth method or not"
}

variable "create_aws_secret_backend_user" {
  type        = bool
  default     = false
  description = "Enable AWS Secret Backend or not for Vault"
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

variable "aws_auth_path_user" {
  type        = string
  default     = "account_b"
  description = "AWS Authentication Methods path"
}

variable "aws_secret_path_user" {
  type        = string
  default     = ""
  description = "AWS Secret engine path for IAM User"
}

variable "create_auth_backend_role_user" {
  type        = bool
  default     = false
  description = "Enable STS role or not on Vault"
}

variable "auth_backend_role_user" { # If enabled, Role that is used by Vault authenticating AWS!
  type = map(object({
    account_id = number
    sts_role   = string
  }))
  default = {
    "acc_b" = {
      account_id = 123123123123
      sts_role   = "arn:aws:iam::123123123123:role/automation-role"
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
  description = "IAM User with defined IAM permission policy"
}

variable "credential_type_user" {
  default     = "iam_user"
  type        = string
  description = "AWS IAM User type"
}

variable "region_user" {
  default     = "us-east-1"
  type        = string
  description = "Region that Vault residing"
}


## JWT
variable "enabled_jwt_backend" {
  type        = bool
  default     = false
  description = "Enable JWT Auth Backend or not"
}

variable "jwt_path" {
  type        = string
  default     = "jwt"
  description = "JWT path"
}

variable "create_acc_role" {
  type        = bool
  default     = false
  description = "Enable Account JWT Auth Backend Role or not"
}

variable "create_secret_role" {
  type        = bool
  default     = false
  description = "Enable Secrets JWT Auth Backend Role or not"
}

variable "bound_issuer" {
  type        = string
  default     = "gitlab.com"
  description = "The value against which to match the iss claim in a JWT"
}

variable "acc_role_name" {
  type        = string
  default     = "ops"
  description = "Accounts role name"
}

variable "acc_token_policies" {
  type = list(string)
  default = [
    "ops",
    "qa"
  ]
  description = "Accounts policy name"
}

variable "acc_bound_claims" {
  type = map(object({
    project_id = number
    ref        = string
    ref_type   = string
  }))
  default = {
    "aws_secret_engine" = {
      project_id = 12312312
      ref        = "main,releae/*"
      ref_type   = "branch"
    }
  }
  description = "JWT/OIDC auth backend role for AWS Account in a Vault server"
}

variable "secret_role_name" {
  type        = string
  default     = "ops"
  description = "Secret role name"
}

variable "secret_token_policies" {
  type        = list(string)
  default     = ["ops"]
  description = "Secrets policy name"
}

variable "secret_bound_claims" {
  type = map(object({
    project_id = number
    ref        = string
    ref_type   = string
  }))
  default = {
    "key" = {
      project_id = 12312312
      ref        = "main,release/*"
      ref_type   = "branch"
    }
  }
  description = "JWT/OIDC auth backend role for Secrets values in a Vault server"
}
