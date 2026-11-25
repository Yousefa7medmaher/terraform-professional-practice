package terraform.policies.public_s3

import rego.v1

deny contains msg if {
	some rc in input.plan.resource_changes
	rc.type == "aws_s3_bucket_public_access_block"
	rc.change.after.block_public_acls == false
	msg := sprintf("%s must block public ACLs", [rc.address])
}
