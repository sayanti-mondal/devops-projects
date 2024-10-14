# created s3 bucket
resource "aws_s3_bucket" "iaac_s3_bucket"{
    bucket = "aws-s3-bucket-created-using-terraform"
}

# created bucket versioning
resource "aws_s3_bucket_versioning" "versioning_example"{
    bucket = aws_s3_bucket.iaac_s3_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

# created IAM user
resource "aws_iam_user" "terraform_iam"{
    name = "terraform_iam_user_updated"
}
# STATE 
# DESIRED - KNOWN - ACTUAL 