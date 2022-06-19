region = "us-east-1"

## KV
vault_addr       = "https://myvault.com"
token            = "hvs.asdfasdASDFASDFZXCV"
create_mountpath = true
vault_mount = {
  "qa" = {
    path        = "qa"
    type        = "kv-v2"
    description = "QA VPC values"
  },
  "uat" = {
    path        = "uat"
    type        = "kv-v2"
    description = "UAT VPC values"
  }
}

## USERPASS
create_userpass = true
users_path = {
  "user1" = {
    data_json = <<EOT
      {
        "policies": ["reader"],
        "password": "reader"
      }
    EOT
    path      = "auth/userpass/users/reader"
  },
  "user2" = {
    data_json = <<EOT
      {
        "policies": ["admin"],
        "password": "admin"
      }
    EOT
    path      = "auth/userpass/users/admin"
  }
}

create_generic_secret = true
generic_secret = {
  "qa" = {
    path                = "qa/network"
    disable_read        = false
    delete_all_versions = false
    data_json           = <<EOF
      {
        "availability_zones": [
            "us-east-1a",
            "us-east-1b",
            "us-east-1c"
        ],
        "aws_region": "us-east-1",
        "create_database_internet_gateway_route": true,
        "create_database_subnet_group": true,
        "create_database_subnet_route_table": true,
        "database_subnets": [
            "10.0.144.0/20",
            "10.0.160.0/20",
            "10.0.176.0/20"
        ],
        "elasticache_subnets": [
            "10.0.96.0/20",
            "10.0.112.0/20",
            "10.0.128.0/20"
        ],
        "environment": "qa",
        "private_subnets": [
            "10.0.48.0/20",
            "10.0.64.0/20",
            "10.0.80.0/20"
        ],
        "public_subnets": [
            "10.0.0.0/20",
            "10.0.16.0/20",
            "10.0.32.0/20"
        ],
        "vpc_cidr": "10.0.0.0/16",
        "vpc_name": "env-qa"
      }
    EOF
  },
  "uat" = {
    path                = "uat/network"
    disable_read        = false
    delete_all_versions = false
    data_json           = <<EOF
      {
        "availability_zones": [
            "us-east-1a",
            "us-east-1b",
            "us-east-1c"
        ],
        "aws_region": "us-east-1",
        "create_database_internet_gateway_route": true,
        "create_database_subnet_group": true,
        "create_database_subnet_route_table": true,
        "database_subnets": [
            "192.168.144.0/20",
            "192.168.160.0/20",
            "192.168.176.0/20"
        ],
        "elasticache_subnets": [
            "192.168.96.0/20",
            "192.168.112.0/20",
            "192.168.128.0/20"
        ],
        "environment": "uat",
        "private_subnets": [
            "192.168.48.0/20",
            "192.168.64.0/20",
            "192.168.80.0/20"
        ],
        "public_subnets": [
            "192.168.0.0/20",
            "192.168.16.0/20",
            "192.168.32.0/20"
        ],
        "vpc_cidr": "192.168.0.0/16",
        "vpc_name": "env-uat"
      }
    EOF
  }
}
create_policy = true
vault_policy = {
  "qa" = {
    name   = "qa-network-read"
    policy = <<EOF
      ## Policy for only reading QA secret values
      path "qa/data/*"
      {
          capabilities = ["read"]
      }
    EOF
  },
  "uat" = {
    name   = "uat-network-read"
    policy = <<EOF
      ## Policy for only reading UAT secret values
      path "uat/data/*"
      {
        capabilities = ["read"]
      }
    EOF
  },
  "account_b" = {
    name   = "account_b"
    policy = <<EOF
      ## Policy for only reading AWS CREDS
      path "aws/creds/account_b"
      {
        capabilities = ["read"]
      }
    EOF
  },
  "reader" = {
    name   = "reader"
    policy = <<EOF
      ## Reader Policy
      path "*"
      {
        capabilities = ["read"]
      }
    EOF
  },
  "admin" = {
    name   = "admin"
    policy = <<EOF
      ## Policy for only reading operations tfvars
      path "*"
      {
        capabilities = ["create", "read", "update", "delete", "list", "sudo"]
      }
    EOF
  }
}

enabled_jwt_backend = true
jwt_path            = "jwt"
create_acc_role     = true
create_secret_role  = true
acc_role_name       = "account_b"
acc_token_policies = [
  "account_b",
]
acc_bound_claims = {
  "qa" = {
    role_name = "qa"
    bound_claims = {
      "project_id" = "23125321"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  },
  "uat" = {
    role_name = "uat"
    bound_claims = {
      "project_id" = "34495162"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  }
}
secret_token_policies = [
  "qa",
  "uat"
]
secret_bound_claims = {
  "uat-network-read" = {
    role_name = "uat-network-read"
    bound_claims = {
      "project_id" = "34495162"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  },
  "qa-network-read" = {
    role_name = "qa-network-read"
    bound_claims = {
      "project_id" = "23125321"
      "ref"        = "main,release/*"
      "ref_type"   = "branch"
    }
  },
}


## ASSUMED_ROLE USER
access_key                = "KOASDJFKASERKLAJEASDF"
secret_key                = "ASDFASzxcvfasrefawetafweaASDFAE"
create_aws_auth_backend   = true
aws_auth_path             = "aws"
create_aws_secret_backend = true
aws_secret_path           = "aws"
create_auth_backend_role  = true
auth_backend_role = {
  "qa" = {
    account_id = "987632910785"
    sts_role   = "arn:aws:iam::987632910785:role/automation-role"
  },
  "uat" = {
    account_id = "342437089605"
    sts_role   = "arn:aws:iam::342437089605:role/automation-role"
  },
}
create_secret_backend_role = true
secret_backend_role = {
  "qa" = {
    name      = "qa"
    role_arns = ["arn:aws:iam::987632910785:role/automation-role"]
  },
  "uat" = {
    name      = "uat"
    role_arns = ["arn:aws:iam::342437089605:role/automation-role"]
  },
}
credential_type = "assumed_role"


## IAM USER
access_key_user                = "ASDFASDFGSHDASDFAS?ERF"
secret_key_user                = "asdfasda4afsefaw4awefaXEfaASDF"
create_aws_auth_backend_user   = false
aws_auth_path_user             = "account_b"
create_aws_secret_backend_user = false
aws_secret_path_user           = "account_b"
create_auth_backend_role_user  = false
auth_backend_role_user = {
  "acc_b" = {
    account_id = "967734273069"
    sts_role   = "arn:aws:iam::967734273069:role/automation-role"
  }
}
create_secret_backend_role_user = false
secret_backend_role_user = {
  "ec2-user" = {
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
credential_type_user = "iam_user"
