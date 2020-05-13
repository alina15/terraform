
# s3 Bucket with Website settings
resource "aws_s3_bucket" "demo" {
  bucket = var.root_domain_name
// Because we want our site to be available on the internet, we set this so anyone can read this bucket.
  acl = "public-read"
// We also need to create a policy that allows anyone to view the content. 
// This is basically duplicating what we did in the ACL but it's required by AWS
// We are sourcing our policy from a file that is under this repository
  policy = file("policy.json")
  website {
// Here we tell S3 what to use when a requiest comes in to the domain
    index_document = "index.html"
// The page to serve up if a request results in an error or a non-existing page
    error_document = "error.html"
  }
}

