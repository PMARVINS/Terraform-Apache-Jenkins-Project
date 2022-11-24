

resource "aws_lb_target_group" "targetgroup" {
  name     = "targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [aws_subnet.SubnetA.id, aws_subnet.SubnetB.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "listner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
  type             = "forward"
  target_group_arn = aws_lb_target_group.targetgroup.arn
  }
}


#Creating Target group and EC2 attachments
resource "aws_lb_target_group_attachment" "alb-attach" {
  target_group_arn = aws_lb_target_group.targetgroup.arn
  target_id        = aws_instance.Instance-1.id 
  port             = 80
}

