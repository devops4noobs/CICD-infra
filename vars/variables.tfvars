igw-name    = "Jenkins-igw"
rt-name     = "Jenkins-route-table"
sg-name = "Jenkins-sg"

iam-role       = "Jenkins-iam-role"
instance-name  = "Jenkins-server"
region         = "eu-central-1"
instance_count = 3
key_name       = "dpp" 
# CIDR Ingress Variables all
create_ingress_cidr      = true
ingress_cidr_from_port   = [22, 8080, 9000, 80, 443, 9090, 9100, 9093, 3000] # List of from ports
ingress_cidr_to_port     = [22, 8080, 9000, 80, 443, 9090, 9100, 9093, 3000] # List of to ports 
ingress_cidr_protocol    = ["tcp", "tcp", "tcp", "tcp", "tcp", "tcp", "tcp", "tcp", "tcp"] # Protocol for all rules (you can add more if needed)
ingress_cidr_block       = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
ingress_cidr_description = ["SSH", "Jenkins", "Sonarqube", "HTTP", "HTTPS", "Prometheus", "Node-exporter", "Alert manager", "Grafana"]

# CIDR Egress Variables all
create_egress_cidr    = true
egress_cidr_from_port = [0]
egress_cidr_to_port   = [0]
egress_cidr_protocol  = ["-1"]
egress_cidr_block     = ["0.0.0.0/0"]