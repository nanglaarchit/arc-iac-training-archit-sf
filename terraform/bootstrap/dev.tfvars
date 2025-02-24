region                   = "us-east-1"
bucket_name              = "archit-nangla-arc-iac"
dynamodb_name            = "archit-nangla-arc-iac"
dynamo_kms_master_key_id = "" // if you want to give your own CMK key then speify the arn else it will use default aws managed dynamo kms key
