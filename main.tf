# Development Environment
module "s3_dev_auth" {
  source      = "./modules/s3"
  bucket_name = "bucket1-dev"
}

module "cloudfront_dev_auth" {
  source              = "./modules/cloudfront"
  s3_bucket_domain_name = module.s3_dev_auth.bucket_domain_name
  origin_id           = "S3-dev-auth"
}

# Repeat for /info and /customers, and for staging and production environments

# IAM Role
module "iam_s3_cloudfront" {
  source         = "./modules/iam"
  role_name      = "iam-role-s3-cloudfront"
  s3_bucket_arn  = module.s3_dev_auth.bucket_arn
}

# Outputs
output "dev_auth_s3_bucket_id" {
  value = module.s3_dev_auth.bucket_id
}

# Repeat for other buckets and CloudFront distributions

