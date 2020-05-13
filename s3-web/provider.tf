// THis block tells Terraform that we're going to provision AWS resources.
provider "aws" {
    region= "us-east-1"
}
provider "aws" {
  alias = "cloudfront"
}
