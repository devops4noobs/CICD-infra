output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public-subnet" {
  value = aws_subnet.public-subnet.id
}