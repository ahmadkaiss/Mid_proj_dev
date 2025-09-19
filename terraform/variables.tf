variable "aws_access_key_id" { type = string, default = "" }
variable "aws_secret_access_key" { type = string, default = "" }
variable "aws_session_token" { type = string, default = "" }

variable "name-prefix" { type = string, default = "North_Virginia" }
variable "ami" { type = string, default = "ami-0360c520857e3138f" }
variable "vm-size" { type = string, default = "t3.small" }
variable "vpc-cidr" { type = string, default = "10.10.0.0/16" }
variable "ip-address" { type = string, default = "0.0.0.0/0" }


variable "vpc-public-subnet-1" { type = string, default = "10.10.1.0/24" }
variable "vpc-public-subnet-2" { type = string, default = "10.10.0.0/24" }
variable "vpc-private-subnet-1" { type = string, default = "10.10.2.0/24" }
variable "vpc-private-subnet-2" { type = string, default = "10.10.3.0/24" }


