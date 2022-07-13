terraform {
  backend "s3" {
    bucket         = "tf-st-bucket-sd"
    key            = "main"
    region         = "us-east-2"
    dynamodb_table = "my-dynamo"
  }
}
