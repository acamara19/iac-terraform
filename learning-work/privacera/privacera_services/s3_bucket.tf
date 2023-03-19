resource "aws_s3_bucket_object" "privacera_folder" {
  for_each = fileset("${path.module}/files-to-upload", "*")

  bucket       = "your-s3-bucket-name"
  key          = "privacera/privacera-eks-prod/${each.value}"
  source       = "${path.module}/files-to-upload/${each.value}"
  etag         = filemd5("${path.module}/files-to-upload/${each.value}")
}

locals {
  files_to_upload = {
    "subfolder1" = fileset("${path.module}/../files_to_upload/subfolder1", "*")
    "subfolder2" = fileset("${path.module}/../files_to_upload/subfolder2", "*")
  }
}

resource "aws_s3_bucket_object" "uploaded_files" {
  for_each = toset(flatten([
    [for file in local.files_to_upload["subfolder1"] : {
      key      = "privacera/privacera-eks-prod/subfolder1/${file}"
      filename = "${path.module}/../files_to_upload/subfolder1/${file}"
    }],
    [for file in local.files_to_upload["subfolder2"] : {
      key      = "privacera/privacera-eks-prod/subfolder2/${file}"
      filename = "${path.module}/../files_to_upload/subfolder2/${file}"
    }]
  ]))

  bucket       = var.s3_bucket_name
  key          = each.value.key
  source       = each.value.filename
  acl          = "private"
  content_type = lookup(local.mime_types, regex("\\.[^.]*$", each.value.filename), "binary/octet-stream")
}

locals {
  mime_types = {
    ".txt"  = "text/plain"
    ".json" = "application/json"
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
  }
}

resource "aws_s3_bucket_object" "uploaded_files" {
  for_each = toset(flatten([
    [for file in local.files_to_upload["subfolder1"] : {
      key      = "root-folder/second-folder/privacera-eks-prod/subfolder1/${file}"
      filename = "${path.module}/../files_to_upload/subfolder1/${file}"
    }],
    [for file in local.files_to_upload["subfolder2"] : {
      key      = "root-folder/second-folder/privacera-eks-prod/subfolder2/${file}"
      filename = "${path.module}/../files_to_upload/subfolder2/${file}"
    }]
  ]))

  bucket       = var.s3_bucket_name
  key          = each.value.key
  source       = each.value.filename
  acl          = "private"
  content_type = lookup(local.mime_types, regex("\\.[^.]*$", each.value.filename), "binary/octet-stream")
}
