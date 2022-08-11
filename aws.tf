terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.25.0"
    }
  }

  backend "http" {
  }
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.REGION
}

resource "aws_iam_user" "new_user" {
  name = "DemoUser"
}

resource "aws_iam_access_key" "AccK" {
  user = aws_iam_user.new_user.name
}

resource "aws_iam_user_policy" "iam" {
  name = "ec2-permission"
  user = aws_iam_user.new_user.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
        }
    ]
}
EOF
}

output "secret_key" {
  value     = aws_iam_access_key.AccK.secret
  sensitive = true
}

output "access_key" {
  value = aws_iam_access_key.AccK.id
}
