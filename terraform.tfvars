instance_type       = "t2.micro"
protocol            = "tcp"
region              = "us-east-2"
cidr                = ["0.0.0.0/0"]
connection_draining = true
common_tags         = "devops14-2021"
az                  = ["us-east-2a", "us-east-2b"]