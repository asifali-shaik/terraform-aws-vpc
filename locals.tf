locals {
  common_tags = {
    project = var.project_name
    envrionment = var.envrionment
    terraform = true
  }
  vpc_final_tags = merge(
     local.common_tags,
    {
        Name = "${var.project_name}-${var.envrionment}"
    },
    var.vpc_tags
  )

  igw_final_tags = merge(
    local.common_tags,{
        Name = "${var.project_name}-${var.envrionment}"
    },
    var.igw_tags
  )
  az_names = slice (data.aws_availability_zones.available.names, 0 , 2)

  
}