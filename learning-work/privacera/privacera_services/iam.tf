data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::ACCOUNT_ID:role/EXTERNAL_ROLE_NAME"]
    }
  }
}

resource "aws_iam_role" "dxdl_svc_privacera" {
  name               = "dxdl-svc-privacera"
  path               = "/OneCloud/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_instance_profile" "dxdl_svc_privacera_instance_profile" {
  name = "dxdl-svc-privacera-instance-profile"
  role = aws_iam_role.dxdl_svc_privacera.name
}

resource "aws_iam_role_policy_attachment" "dxdl_svc_privacera_policy_attachment" {
  policy_arn = aws_iam_policy.customer_managed_policy.arn
  role       = aws_iam_role.dxdl_svc_privacera.name
}

resource "aws_iam_policy" "customer_managed_policy" {
  name        = "CustomerManaged-dxdl-svc-privacera"
  description = "Customer Managed policy for dxdl-svc-privacera role"
  policy      = data.aws_iam_policy_document.customer_managed_policy.json
}

data "aws_iam_policy_document" "customer_managed_policy" {
  statement {
    actions = [
      "ec2:Describe*",
      "s3:List*",
      "s3:Get*",
    ]

    resources = [
      "*",
    ]
  }
}
