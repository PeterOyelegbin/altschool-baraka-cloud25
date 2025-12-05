output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "alb_dns_name" {
  description = "DNS name of Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "bastion_host_public_ip" {
  description = "Public IP of Bastion host"
  value       = aws_instance.bastion_host.public_ip
}

output "web_servers_private_ips" {
  description = "Private IPs of web servers"
  value       = aws_instance.web_servers[*].private_ip
}

output "database_server_private_ip" {
  description = "Private IP of database server"
  value       = aws_instance.database_server.private_ip
}

output "ssh_key_files" {
  description = "Paths to the generated SSH key files"
  value = {
    private_key = local_file.private_key.filename
  }
}

output "connection_instructions" {
  description = "Instructions to connect to instances"
  value       = <<EOT
Connection Instructions:
1. Access Web Application:
   http://${aws_lb.web_alb.dns_name}
   
2. Connect to Bastion Host:
   ssh -i ${local_file.private_key.filename} ec2-user@${aws_instance.bastion_host.public_ip}

3. From Bastion, connect to Web Servers:
   ssh ${var.web_server_username}@<web-server-private-ip>

4. From Bastion, connect to Database Server:
   ssh ${var.db_username}@${aws_instance.database_server.private_ip}

5. Database Connection:
   mysql -h ${aws_instance.database_server.private_ip} -u ${var.db_username} -p techcorp_db
   
Web Server Username: ${var.web_server_username}
Database Username: ${var.db_username}
EOT
}
