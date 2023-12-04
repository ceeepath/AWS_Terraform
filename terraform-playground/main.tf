data "aws_acm_certificate" "issued" {
  domain   = "adejikunle.com"
  statuses = ["ISSUED"]
}

output "zone_id" {
  value = data.aws_acm_certificate.issued.arn

