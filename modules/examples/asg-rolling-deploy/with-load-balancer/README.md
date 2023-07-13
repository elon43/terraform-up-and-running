This example calls the asg-rolling-deploy module to deploy a single EC2 instance without auto-scaling.  The alb module is called to deplay an Application Load Balancer.  The EC2 user_data loads a webserver running on port 8080. 

However the load balancer target group not the load balancer rule is integrated at this step.  These will be added when the application is deployed.  Therefore, the application running on the host can not be reached.

asg-rolling-deploy MODULE VARIABLES
subnet_ids = data.aws_subnets.default.ids

user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p ${var.server_port} &
            EOF

ami = data.aws_ami.ubuntu.id

instance_type = "t2.micro"

min_size = 1
max_size = 1

enable_autoscaling = false

#These values change be changed by overriding the default values
cluster_name = "stage"
server_port = 8080

alb MODULE VARIABLES
alb_name = "stage-ALB"
 subnet_ids = data.aws_subnets.default.ids