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
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_iam_user" "new_user" {
  name = "DemoUser"
}

resource "aws_iam_access_key" "AccK" {
  user = aws_iam_user.new_user.name
}

output "secret_key" {
  value = aws_iam_access_key.AccK.secret
  sensitive = true
}

output "access_key" {
  value = aws_iam_access_key.AccK.id
}
