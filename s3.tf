# Variable juste pour dire
variable "nom_prenom" {
  type    = string
  default = "quentinlauret"
}


# Create S3 bucket with versioning enabled
resource "aws_s3_bucket" "ynov_infracloud" {
  bucket = "ynov-infracloud-${var.nom_prenom}"
  acl    = "public-read"  # askip c'est déprécié

  versioning {
    enabled = true
  }
}

# Upload de l'image
resource "aws_s3_object" "puppy_jpg" {
  bucket = aws_s3_bucket.ynov_infracloud.bucket
  key    = "assets/puppy.jpg"
  source = "assets/puppy.jpg"

  acl          = "public-read"  # là ça l'est pas
  content_type = "image/jpeg"
}

# Le bucket en accès public
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.ynov_infracloud.bucket
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = [
          "${aws_s3_bucket.ynov_infracloud.arn}/*",
        ],
      },
    ],
  })
}
