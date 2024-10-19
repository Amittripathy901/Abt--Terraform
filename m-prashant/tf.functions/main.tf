terraform {}


locals {
  value = "Hello World!"
}

variable "string_list" {
  type = list(string)
  default = [ "Serv1", "Serv2", "Serv3", "Serv1" ]
}

output "output" {
  #value = upper(local.value)
  #value = startswith(local.value, "Hello")
  #value = split(" ", local.value)
  #value = min(1,2,3,4,5)
  #value = abs(-15)
  #value = length(var.string_list)  #-->Length of the string
  #value = join(":", var.string_list)
  #value = contains(var.string_list, "Serv1") #-->Contains the value or not
  value = toset(var.string_list) #-->Remove duplicate

}