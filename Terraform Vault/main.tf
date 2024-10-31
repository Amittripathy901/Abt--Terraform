provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  address = "http://43.204.101.181:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "f6f1adb5-75a3-20c2-61cf-920d804807f3"
      secret_id = " bd76567a-ddce-c8ae-36f0-1d3cbdd364d6"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  mount = "kv" 
  name  = "Test-Secret" 
}

resource "aws_instance" "vault" {
   ami = "ami-0dee22c13ea7a9a67"
   instance_type = "t2.micro"

   tags = {
    secret = data.vault_kv_secret_v2.example.data["username"]
       }
}