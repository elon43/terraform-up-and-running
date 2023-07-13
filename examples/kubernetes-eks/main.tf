provider "aws" {
  region = "us-east-2"
}

# Kubernetes Provider Credentials
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
provider "kubernetes" {
  host = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(
    module.eks_cluster.cluster_certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.cluster.token
}

# Get Authentication Token to Communicate with the EKS Cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_name
}

module "eks_cluster" {
  source = "../../modules/services/eks-cluster"

  name               = "example-eks-cluster2"
  min_size           = 1
  max_size           = 2
  desired_size       = 1
  kubernetes_version = "1.27"
  instance_types     = ["t3.small"]
}

module "simple_webapp" {
  source = "../../modules/services/k8s-app"

  name           = "simple-webapp"
  image          = "training/webapp"
  replicas       = 2
  container_port = 5000

  environment_variables = {
    PROVIDER = "Readers"
  }

  depends_on = [module.eks_cluster]
}

output "service_endpoint" {
  value       = module.simple_webapp.service_endpoint
  description = "The K8S Service Endpoint"
}