locals {
  existing_buckets = {
    one = "yousef-clickops-1"
    two = "yousef-clickops-2"
  }
}

# Option A: one resource
# import {
#   to = aws_s3_bucket.single
#   id = "yousef-clickops-1"
# }

# Option B: many resources with for_each (Terraform >= 1.7)
import {
  for_each = local.existing_buckets
  to       = aws_s3_bucket.this[each.key]
  id       = each.value
}

resource "aws_s3_bucket" "this" {
  for_each = local.existing_buckets
  bucket   = each.value
}
