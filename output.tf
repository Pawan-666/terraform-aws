output "count1" {
  value = length(var.public_cidr)
}

output "count2" {
  value = length(var.private_cidr)
}

output public_ip {
  value = aws_instance.public.public_ip
}

output private_ip {
  value = aws_instance.private.private_ip
}
