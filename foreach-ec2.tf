resource "aws_instance" "test" {
  for_each = var.instance
  ami           = each.value.ami
  instance_type = each.value.type
  tags = {
    Name = each.key
  }
}


# resource "aws_instance" "test" {
#   for_each = toset(["server-1", "server-2","server-3"])
#   ami           = "ami-00f7e5c52c0f43726"
#   instance_type = "t2.micro"
#   tags = {
#     Name = each.key
#   }
# }

# # VPC variable
# variable "vpc-cidr"{
#     default = "10.0.0.0/16"
#     }
# # Subnets variable
# variable "vpc-subnets" {
#     default = ["10.0.0.0/20","10.0.16.0/20","10.0.32.0/20"]
# }

# resource "aws_vpc" "vpc" {
#  cidr_block = var.vpc-cidr
# }

# resource "aws_subnet" "main-subnet" {
# for_each = toset(var.vpc-subnets)
# cidr_block = each.value
# vpc_id = aws_vpc.vpc.id
# }
variable "instance" {
  default = {
    "server-1" = {type = "t2.micro" , ami = "ami-03c1fac8dd915ff60"},
    "server-2" = {type = "t2.medium" , ami = "ami-03c1fac8dd915ff60"},
    "server-3" = {type = "t2.nano" , ami = "ami-03c1fac8dd915ff60"}
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}
