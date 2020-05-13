// This Route53 record wil; point at our CloudFront distribution
resource "aws_route53_record" "demo" {
  zone_id = var.zone_id
  name    = var.root_domain_name
  type    = "A"

  alias  {
    name                   = aws_cloudfront_distribution.demo.domain_name
    zone_id                = aws_cloudfront_distribution.demo.hosted_zone_id
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone.id
  records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

data "aws_route53_zone" "zone" {
  name         = var.root_domain_name
  private_zone = false
}
