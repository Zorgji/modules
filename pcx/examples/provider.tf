terraform {
  required_version = ">= v1.1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16.0"
    }
  }

  backend "s3" {
    bucket  = "S3_BUCKET"          # Replace PCX STATE BUCKET NAME
    key     = "STATE_NAME.tfstate" # Replace PCX STATE FILE NAME
    region  = "REGION"
    encrypt = true
  }
}

provider "aws" {
  region  = "REGION"            # Replace region
  alias   = "request"
  profile = "REQUESTER_PROFILE" # Replace request AWS profile
}
provider "aws" {
  region  = "REGION"            # Replace region
  alias   = "accept"
  profile = "ACCEPTER_PROFILE" # Replace accept AWS profile
}
