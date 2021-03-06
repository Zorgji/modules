module "pcx" {

  providers = {
    aws.requester = aws.request
    aws.accepter  = aws.accept
  }

  # source        = "git::github.com/Zorgji/modules.git//pcx/modules
  source        = "git::github.com/Zorgji/modules.git//pcx/modules?ref=v1.0.2" ## using specific tags
  request_s3    = var.request_s3
  request_state = var.request_state
  accept_s3     = var.accept_s3
  accept_state  = var.accept_state
  accept_region = var.accept_region
  tags          = var.tags
}