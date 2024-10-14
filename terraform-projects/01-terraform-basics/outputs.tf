output "s3_bucket_versioning_value"{
    value = aws_s3_bucket_versioning.versioning_example.versioning_configuration[0].status
}

output "s3_bucket_complete_details"{
    value = aws_s3_bucket.iaac_s3_bucket
}

output "iam_user_details"{
    value = aws_iam_user.terraform_iam
}