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
  key_name = "project"
}
