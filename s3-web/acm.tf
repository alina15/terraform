// Use the AWS Certificate Manager to create an SSL cert for our domain.
// This resource won't be created until it validates the DNS 
resource "aws_acm_certificate" "cert" {
// It called a wildcard cert, so we can host subdomains later.
  domain_name       = "www.aspiretoinspire.de"
  subject_alternative_names = [var.domain_name]
  validation_method = "DNS"


}


resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    "aws_route53_record.cert_validation.fqdn"
  ]
}

# https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-invalid-viewer-certificate/
