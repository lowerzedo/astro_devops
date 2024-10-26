output "web_alb_dns_name" {
  description = "DNS name of the public Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}

output "app_internal_alb_dns_name" {
  description = "DNS name of the internal Application Load Balancer"
  value       = aws_lb.app_internal_alb.dns_name
}

output "db_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.default.endpoint
}

output "private_zone_name" {
  description = "Name of the Route53 private hosted zone"
  value       = aws_route53_zone.private_zone.name
}