resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
  
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id 

  tags = local.igw_final_tags
}

#public subnets
 resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,{
      Name = "${var.project_name}-${var.envrionment}-public-${local.az_names[count.index]}"
    },
      var.public_subnet_tags
  )
      

 }

 #private subnets
resource "aws_subnet" "private" {
    count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  

  tags = merge(
    local.common_tags,{
      Name = "${var.project_name}-${var.envrionment}-private-${local.az_names[count.index]}"
    },
      var.private_subnet_tags
  )
      

 } 

 #database subnets
resource "aws_subnet" "database" {
    count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  

  tags = merge(
    local.common_tags,{
      Name = "${var.project_name}-${var.envrionment}-database-${local.az_names[count.index]}"
    },
      var.database_subnet_tags
  )
      

 } 
 
 resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

    tags =merge(
    local.common_tags,{
      Name = "${var.project_name}-${var.envrionment}-public"
    },
      var.public_route_table_tags
  )
}

 resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

    tags =merge(
    local.common_tags,{
      Name = "${var.project_name}-${var.envrionment}-private"
    },
      var.private_route_table_tags
  )
}

 resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

    tags =merge(
    local.common_tags,{
      Name = "${var.project_name}-${var.envrionment}-database"
    },
      var.database_route_table_tags
  )
}

