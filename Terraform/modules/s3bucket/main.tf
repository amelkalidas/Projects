resource "aws_s3_bucket" "storage" {
  bucket = var.s3_bucket
  force_destroy = true

  tags = {
    Name        = "mys3for3tierapp15"
    Environment = "Dev"
  }
}

output "s3_bucket_arn" {
    value = aws_s3_bucket.storage.bucket 
}
output "s3_bucket_prefix" {
    value = aws_s3_bucket.storage.bucket_prefix
  
}