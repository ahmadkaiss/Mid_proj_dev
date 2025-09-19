output "Public-VM-IP" {
    value = aws_instance.Control-VM.public_ip
}

output "Private1-VM-IP" {
    value = aws_instance.App1-VM.private_ip
}

output "Private2-VM-IP" {
    value = aws_instance.App2-VM.private_ip
}

output "ALB-DNS-Name" {
    value = aws_lb.ALB.dns_name
}
