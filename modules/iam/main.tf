resource "aws_iam_role" "iam_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
      },
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
      }
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name   = "${var.role_name}-s3-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect = "Allow",
        Resource = [
          "${var.s3_bucket_arn}/*",
          var.s3_bucket_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

variable "role_name" {}
variable "s3_bucket_arn" {}

output "role_arn" {
  value = aws_iam_role.iam_role.arn
}

