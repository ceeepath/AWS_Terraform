# Get RHEL AMI
data "aws_ami" "latest_rhel" {
  most_recent = true

  dynamic "filter" {
    for_each = var.rhel_ami_filters
    content {
      name   = filter.key
      values = filter.value
    }
  }

  owners = ["309956199498"]
}

# Get SSH Key
data "aws_key_pair" "ssh" {
  key_name = var.ssh_key
}

# Get Hosted Zone ID
data "aws_route53_zone" "zone" {
  name = "adejikunle.com"
}

# Get Public SSL/TLS Certificate ARN
data "aws_acm_certificate" "issued" {
  domain   = "adejikunle.com"
  statuses = ["ISSUED"]
}
