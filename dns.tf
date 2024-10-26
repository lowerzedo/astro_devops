resource "aws_route53_zone" "private_zone" {
  name = "${var.app_name}.internal"
  vpc {
    vpc_id = aws_vpc.main.id
  }
}

resource "aws_route53_record" "app_record" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "app.${aws_route53_zone.private_zone.name}"
  type    = "A"

  alias {
    name                   = aws_lb.app_internal_alb.dns_name
    zone_id                = aws_lb.app_internal_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "db_record" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "db.${aws_route53_zone.private_zone.name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_db_instance.default.address]
}