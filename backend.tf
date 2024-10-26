# Need to create that S3 bucket to store the Terraform state file. So later we can use tf destroy to remove all the resources we created.
terraform {
  backend "s3" {
    region = "ap-southeast-5"
    bucket = "nazar-temp-terraform-state"
    key    = "terraform.tfstate"
  }
}