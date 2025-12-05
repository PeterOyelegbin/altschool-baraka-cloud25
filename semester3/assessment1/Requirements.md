# Business Requirements:
TechCorp is launching a new web application that needs:
- High availability across multiple availability zones
- Secure network isolation with public and private subnets
- Load balancing for web traffic
- Bastion host for secure administrative access
- Scalable architecture that can grow with the business

---

## Technical Requirements
You must create Terraform configurations to provision the following AWS infrastructure:
1. Virtual Private Cloud (VPC)
    - VPC with CIDR block 10.0.0.0/16
    - Name tag: techcorp-vpc
    - Enable DNS hostnames and DNS support

2. Subnets
Create the following subnets in two different availability zones:
    - Public Subnets:
        * techcorp-public-subnet-1 – CIDR: 10.0.1.0/24
        * techcorp-public-subnet-2 – CIDR: 10.0.2.0/24
    - Private Subnets:
        * techcorp-private-subnet-1 – CIDR: 10.0.3.0/24
        * techcorp-private-subnet-2 – CIDR: 10.0.4.0/24

3. Internet Gateway & NAT Gateways
    - Internet Gateway attached to the VPC
    - NAT Gateway in each public subnet for private subnet internet access
    - Appropriate route tables and associations

4. Security Groups
    - Web Security Group: Allow HTTP (80), HTTPS (443) from anywhere, SSH (22) from Bastion Security Group.
    - Database Security Group: Allow MySQL (3306) only from web security group Allow SSH(22) from Bastion Security Group.
    - Bastion Security Group: Allow SSH (22) from your current IP address only

5. EC2 Instances
    - Bastion Host:
        * t3.micro instance in public subnet
        * Use Amazon Linux 2 AMI
        * Associate Elastic(Public) IP
    - Web Servers:
        * 2x t3.micro instances (one in each private subnet)
        * Use Amazon Linux 2 AMI
        * Install Apache web server (user data script)
    - Database Server:
        * 1x t3.small instance in private subnet
        * Use Amazon Linux 2 AMI
        * Install PostgresDB using (user data script)
**NOTE: Setup Access from Bastion to Web and Dev servers using username and password. Usage of ssh keys is an optional alternative.**

6. Application Load Balancer
    - Application Load Balancer in public subnets
    - Target group pointing to web servers
    - Health check configuration
7. Variables and Outputs
    - Use variables for: region, instance types, key pair name, your IP address
    - Output: VPC ID, Load Balancer DNS name, Bastion public IP

---

## Submission Requirements
Required Files Structure:
terraform-assessment/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── user_data/
│   └── web_server_setup.sh
│   └── db_server_setup.sh
└── README.md

1. Terraform Configuration Files
    - main.tf: All resource definitions
    - variables.tf: Variable declarations with descriptions and default values
    - outputs.tf: Output definitions
    - terraform.tfvars.example: Example variable values (without sensitive data)
2. User Data Script
    - user_data/web_server_setup.sh: Script to install and configure Apache
    - Should install Apache, enable it, and create a simple HTML page showing the instance ID
    - user_data/db_server_setup.sh: Script to install and configure Apache
    - Should install and setup Postgres DB
3. Documentation
    - README.md: Instructions on how to deploy and destroy the infrastructure
    - Include prerequisites, deployment steps, and cleanup instructions
4. Deployment Evidence
    - Screenshots of:
        * Terraform plan output
        * Terraform apply completion
        * AWS Console showing created resources
        * Load balancer serving web pages from both instances
        * SSH access through bastion host
        * SSH access to the Web and DB servers.
        * Connect to the postgres instance on the DB server
        * Web access to the Web servers via the ALB URL(must be visible in the screenshot).
5. Terraform State
    - Export terraform state file (terraform.tfstate) – ensure no sensitive data is exposed

---

## Submission Guidelines
- Submission Method:
    * Create a GitHub repository named month-one-assessment
    * Upload all required files following the specified structure
    * Include deployment evidence in a folder named evidence/
- [Assessment Document](https://docs.google.com/document/d/1pgQZnvYxnnnTjJTaAxLC5mfLeMbDbapHj24218f71SE/edit?tab=t.0)
