This example calls the hello-world-app module.  The hello-world-app module calls the asg-rolling-deploy and alb modules.  These modules create an auto scaling group and an application load balancer, respectively.  The EC2 user_data loads a webserver running on port 8080. 

db_remote_state_bucket = "terraform-up-and-running-state-sct6443"
db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

environment = "stage"
ami = data.aws_ami.ubuntu.id
instance_type = "t2.micro"
server_port = 8080
server_text = "This is a test"
min_size = 1
max_size = 1
enable_autoscaling = false
cluster_name = "Test-Cluster"
subnet_ids = data.aws_subnets.default.ids