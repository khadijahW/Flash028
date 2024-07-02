# Creating a VPC , Two public subnets,Two private subnets (application tier), Two private subnets (Database Tier)
resource "aws_default_vpc" "default" {
    cidr block ="10"
  tags = {
    Name = "Default VPC"
  }
}