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
  region  = "us-east-1"
  alias   = "request"
  profile = "REQUESTER_PROFILE" # Replace request AWS profile
}
provider "aws" {
  region  = "ap-southeast-1"
  alias   = "accept"
  profile = "ACCEPTER_PROFILE" # Replace accept AWS profile
}
