## Deployment steps
1. Initialize Terraform:
```bash
terraform init
```

2. Validate and see plan:
```bash
terraform plan -var-file="terraform.tfvars"
```
![terraform_plan](http://)

3. Apply:
```bash
terraform apply -var-file="terraform.tfvars"
```
**Note: Approve the apply prompt or add -auto-approve if you understand the changes.**
![terraform_apply](http://)

4. After apply completes:
    - Outputs printed include vpc_id, alb_dns_name, and bastion_public_ip.
    - ALB DNS (http) should serve the simple HTML page created by the web servers.
    - Use the bastion host to SSH into private web and db servers.

## Verify Deployment
1. ALB serving web content
This displays both web content 1 and web content 2 simultaneously on reload.
![terraform_apply](http://)

2. SSH into bastion
```bash
ssh -i /path/to/key.pem ec2-user@<bastion_public_ip>
```
![terraform_apply](http://)

3. From bastion, SSH into a web server (private IP visible in AWS Console)
```bash
ssh ec2-user@<web_private_ip>
```
**Note: Use the admin_password you set**
![terraform_apply](http://)

4. Database access
From the bastion or web server, connect to Postgres:
```bash
psql -h 10.0.3.X -U techcorpuser -W -d techcorpdb
```
**password: value of db_password**
![terraform_apply](http://)

## Cleanup / Destroy
To remove everything:
```bash
terraform destroy -var-file="terraform.tfvars"
```
Confirm the destroy prompt or append -auto-approve.
