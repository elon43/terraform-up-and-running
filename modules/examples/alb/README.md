This example calls alb module to deploy an application load balancer.  The load balancer listens on port 80.

subnet_ids = data.aws_subnets.default.ids
vpc_id = data.aws_vpc.default.id

#These values change be changed by overriding the default values
alb_name = "${var.cluster_name}-ALB"
server_port = var.server_port

