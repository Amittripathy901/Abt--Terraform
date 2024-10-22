variable "ec2_map" {
  # key=value (object{ami, inst})
  type = map(object({
    ami           = string
    instance_type = string
  }))

}