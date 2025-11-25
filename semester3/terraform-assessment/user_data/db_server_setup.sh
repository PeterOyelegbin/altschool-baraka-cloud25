#!/bin/bash
# Update system
yum update -y

# Install MySQL Server
amazon-linux-extras install epel -y
yum install -y mysql-server

# Start MySQL
systemctl start mysqld
systemctl enable mysqld

# Wait for MySQL to start
sleep 10

# Create MySQL configuration to skip password validation for initial setup
cat > /tmp/mysql_commands.sql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${password}';
CREATE DATABASE techcorp_db;
CREATE USER '${username}'@'%' IDENTIFIED BY '${password}';
GRANT ALL PRIVILEGES ON techcorp_db.* TO '${username}'@'%';
FLUSH PRIVILEGES;
EOF

# Execute MySQL commands
mysql -u root < /tmp/mysql_commands.sql

# Remove temporary file
rm -f /tmp/mysql_commands.sql

# Configure MySQL to allow remote connections
sed -i 's/bind-address = 127.0.0.1/bind-address = 0.0.0.0/' /etc/my.cnf

# Restart MySQL
systemctl restart mysqld

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
