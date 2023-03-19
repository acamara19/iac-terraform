resource "aws_s3_bucket_object" "privacera_folder" {
  for_each = fileset("${path.module}/files-to-upload", "*")

  bucket       = "your-s3-bucket-name"
  key          = "privacera/privacera-eks-prod/${each.value}"
  source       = "${path.module}/files-to-upload/${each.value}"
  etag         = filemd5("${path.module}/files-to-upload/${each.value}")
}
