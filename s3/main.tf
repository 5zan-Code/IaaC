resource "aws_s3_bucket" "finance" {
  bucket     = "finance-07709980"
  depends_on = [random_id.bucketPostName]
}

resource "random_id" "bucketPostName" {
  byte_length = 4
}

resource "random_string" "content" {
  length  = 50
  special = false
}

resource "local_file" "financeFile01" {
  filename = "./financefile"
  content  = "File content: ${random_string.content.result}"
}

resource "aws_s3_object" "myfile" {
  bucket = aws_s3_bucket.finance.bucket
  key    = local_file.financeFile01.filename
  source = "./${local_file.financeFile01.filename}"

}


