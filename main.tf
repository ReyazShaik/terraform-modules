provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "ec2" {
  source        = "./modules/ec2-instances"
  ami           = "ami-02ddb77f8f93ca4ca"       # Amazon Linux 2023 in ap-south-1
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnet_id  # public_subnet_id is a output of VPC module output.tf. Output of VPC module is the input here
}

module "s3" {
  source      = "./modules/s3-bucket"
  bucket_name = "my-demo-bucket-bkt-test-1"     # Change to a unique bucket name
}
output "instance_id" {
  value = module.ec2.instance_id
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

