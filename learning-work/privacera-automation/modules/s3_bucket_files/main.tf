variable "bucket_name" {}

variable "file_paths" {
  type = list(string)
}

resource "aws_s3_bucket_object" "my_objects" {
  for_each = { for idx, path in var.file_paths : idx => path }

  bucket = var.bucket_name
  key    = each.value
  source = each.value
}
