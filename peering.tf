resource "aws_vpc_peering_connection" "default" {

    count = var.is_peering_requried? 1 : 0
  
  peer_vpc_id   = data.aws.vpc.default.id  #accepter vpc
  vpc_id        = aws_vpc.main.id          #requester vpc
  auto_accept = true

  tags = merge(
    local.common_tags ,{
        Name = "${var.project_name}-${var.envrionment}-default"
    }

    
  )

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}