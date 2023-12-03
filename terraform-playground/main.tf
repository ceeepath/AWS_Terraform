data "aws_key_pair" "ssh" {
  key_name = "project"
}

output "name" {
  value = data.aws_key_pair.ssh.key_name
}
