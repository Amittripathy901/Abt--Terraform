variable "vpc_config" {
    description = "To get the cidr and name of vpc from user"
  type = object({
    cidr_block = string
    name = string
  })
}