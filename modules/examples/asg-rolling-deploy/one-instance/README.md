This example calls the asg-rolling-deploy module to deploy a single EC2 instance without auto-scaling.  The EC2 user_data loads a webserver running on port 8080. 

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

server_port = 8080
cluster_name = "stage"