resource "aws_s3_bucket" "primary" {
  bucket = "yousef-practice-primary"
}

resource "aws_s3_bucket" "dr" {
  provider = aws.west
  bucket   = "yousef-practice-dr"
}

module "replicated_bucket" {
  source = "./modules/replicated-bucket"

  providers = {
    aws         = aws
    aws.replica = aws.west
  }

  name = "yousef-practice-replicated"
}
