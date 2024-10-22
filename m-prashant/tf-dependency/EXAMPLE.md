resource "aws_security_group" "example" {
    name = "example"
}

resource "aws_instance" "example" {
    ami = " "
    instance_type= " "

    depends_on = [
        aws_security_group.example
    ]
}