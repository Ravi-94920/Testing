resource "aws_kms_key" "backup_key" {
  description  = "Key used for encrypting backups"
  enabled      = true
  key_usage    = ["ENCRYPT_DECRYPT"]
  deletion_window_in_days = 7
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action": [
          "kms:DescribeKey",
          "kms:EnableKey",
          "kms:DisableKey",
          "kms:GetPublicKey",
          "kms:GetKeyPolicy",
          "kms:GetKeyRotationStatus",
          "kms:UpdateKeyDescription",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:Decrypt"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "backup.amazonaws.com"
        },
        "Action": [
          "kms:Decrypt",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:Encrypt"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_backup_vault" "default" {
  name        = "my-backup-vault"
  encryption_key_arn = aws_kms_key.backup_key.arn
  tags = {
    Name = "My Backup Vault"
  }
}