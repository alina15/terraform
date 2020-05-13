locals {
        s3_origin_id = "S3-${var.domain_name}"
      }
resource "aws_cloudfront_distribution" "demo" {
  // "origin" is where CloudFront gets its content from. 
  origin {
    // We need to set up a "custom" origin because otherwise CloudFront won't redirect traffic from the domain to the www domain.
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
    // Here we are using our S3 bucket's URL which is created by AWS. 
    domain_name = "aspiretoinspire.de.s3-website-us-east-1.amazonaws.com"
    // This can be any name to indentify  this origin.
    origin_id   = "aspiretoinspire.de.s3-website-us-east-1.amazonaws.com"
  }

  enabled             = true
  default_root_object = "index.html"

  // All values are defaults from the AWS console.
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "aspiretoinspire.de.s3-website-us-east-1.amazonaws.com"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  // Here we are ensuring we can hit this distribution using domain_name rather than the domain name CloudFront gives.
  aliases = [ "var.root_domain_name", "var.domain_name" ] 

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  // Here's where our certificate is loaded in
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }
  // Here is depends_on function from terraform, We are saying that "if certificate does not exist, it will not create Cloudfront"
  // Otherwise our code will stop or fail.
  depends_on = [aws_acm_certificate.cert]
}
