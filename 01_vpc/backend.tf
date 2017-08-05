# # /*
# # # Use "terraform init" to initialize the configuration.
# # # You need to run terraform apply first to create the S3 bucket and DynamoDB table.
# # # Then, comment out this backend file.
# # */

terraform {
    backend "s3" {
        bucket  = "tmp-tf-state-s3" # Change your bucket name here
        key     = "01_vpc.tfstate"
        region  = "ap-southeast-2" # Your region
        encrypt = "true"
        dynamodb_table = "terraform_statelock" # Your DynamoDB table with LockID
    }
}