# tf-ans-lab1 (updated)
This repository contains a Terraform + Ansible lab for deploying:
 - 1 public control VM running Ansible
 - 2 private app VMs hosting a Flask app (it-asset-management)
 - An Application Load Balancer distributing traffic to the app VMs
 - Optional S3 + DynamoDB backend for terraform state

IMPORTANT: You MUST change the S3 bucket name in terraform/backend-main.tf before creating resources.
See the `ansible` folder for the bootstrap user-data and the playbook to deploy the Flask app.
