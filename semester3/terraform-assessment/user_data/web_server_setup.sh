#!/bin/bash
# Update system
yum update -y

# Install Apache
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Create a simple index.html
echo "<!DOCTYPE html>
<html>
<head>
    <title>Welcome to TechCorp</title>
</head>
<body>
    <h1>Welcome to TechCorp Web Server</h1>
    <p>Server: $(hostname)</p>
    <p>Availability Zone: $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
</body>
</html>" > /var/www/html/index.html

# Create user for SSH access (alternative to key-based SSH)
useradd -m -s /bin/bash ${username}
echo "${username}:${password}" | chpasswd
usermod -aG wheel ${username}

# Configure SSH to allow password authentication
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Install stress tool for testing (optional)
yum install -y stress
