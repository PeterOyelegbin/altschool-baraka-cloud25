#!/bin/bash
# Update system
yum update -y

# Install MySQL Server
amazon-linux-extras install epel -y
yum update -y
yum install -y mariadb-server

# Start and enable the service
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Wait for MySQL to start
sleep 10

# Create MySQL configuration to skip password validation for initial setup
mysql -u root <<EOF
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${password}');
CREATE DATABASE techcorp_db;
CREATE USER 'peteroyelegbin'@'%' IDENTIFIED BY '${password}';
GRANT ALL PRIVILEGES ON techcorp_db.* TO 'peteroyelegbin'@'%';
FLUSH PRIVILEGES;
EOF

# Configure MySQL to allow remote connections
sed -i 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' /etc/my.cnf

# Restart MariaDB
systemctl restart mariadb

# Create user for SSH access
useradd -m -s /bin/bash ${username}
echo "${username}:${password}" | chpasswd
usermod -aG wheel ${username}

# Configure SSH to allow password authentication
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Install MySQL client (useful for testing)
yum install -y mysql

echo "MySQL installation and configuration completed successfully!"
