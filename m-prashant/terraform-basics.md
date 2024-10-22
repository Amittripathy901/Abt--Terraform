# Terraform Basics Tutorial

## 1. Introduction to Terraform

Terraform is an Infrastructure as Code (IaC) tool that allows you to define and manage your infrastructure using declarative configuration files.

Key concepts:
- **Infrastructure as Code (IaC)**: Manage infrastructure using code
- **Declarative**: You specify the desired end-state, not the steps to get there
- **Provider-agnostic**: Works with various cloud providers and services

## 2. Installation

1. Download Terraform from the official website
2. Add Terraform to your system PATH
3. Verify installation: `terraform version`

## 3. Basic Terraform Workflow

1. Write: Create Terraform configuration files (.tf)
2. Plan: Preview changes with `terraform plan`
3. Apply: Make changes with `terraform apply`
4. Destroy: Remove infrastructure with `terraform destroy`

## 4. Terraform Configuration Basics

Terraform uses HashiCorp Configuration Language (HCL). Basic structure:

```hcl
# Configure the provider
provider "aws" {
  region = "us-west-2"
}

# Define a resource
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

## 5. Key Terraform Concepts

### a. Providers
Providers are plugins that allow Terraform to interact with cloud platforms and other services.

```hcl
provider "aws" {
  region = "us-west-2"
}
```

### b. Resources
Resources are the individual infrastructure components you want to create.

```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

### c. Variables
Variables allow you to parameterize your configurations.

```hcl
variable "instance_type" {
  default = "t2.micro"
}

resource "aws_instance" "example" {
  instance_type = var.instance_type
}
```

### d. Outputs
Outputs allow you to display or expose certain values after applying your configuration.

```hcl
output "instance_ip" {
  value = aws_instance.example.public_ip
}
```

### e. Data Sources
Data sources allow you to fetch and use information defined outside of Terraform.

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
```

## 6. State Management

Terraform keeps track of your infrastructure in a state file.

- By default, state is stored locally in `terraform.tfstate`
- For team collaboration, use remote state (e.g., S3, Terraform Cloud)

## 7. Modules

Modules are reusable components in Terraform.

```hcl
module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}
```

## 8. Best Practices

1. Use version control (e.g., Git) for your Terraform configurations
2. Implement remote state management
3. Use modules for reusable components
4. Follow a consistent naming convention
5. Use variables and locals to make your code DRY (Don't Repeat Yourself)
6. Regularly update Terraform and providers

## 9. Advanced Topics (for further exploration)

- Workspaces
- Remote Backends
- State Locking
- Provisioners
- Terraform Cloud

## 10. Advanced Data Types and Functions

### a. Maps

Maps are key-value pairs in Terraform. They're useful for grouping related values.

```hcl
variable "ami_ids" {
  type = map(string)
  default = {
    "us-east-1" = "ami-0747bdcabd34c712a"
    "us-west-2" = "ami-0c55b159cbfafe1f0"
  }
}

resource "aws_instance" "example" {
  ami = var.ami_ids[var.region]
  instance_type = "t2.micro"
}
```

### b. Lists

Lists are ordered collections of values.

```hcl
variable "subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
```

### c. Objects

Objects are complex data types that can include multiple types of values.

```hcl
variable "instance_settings" {
  type = object({
    instance_type = string
    ami_id        = string
    tags          = map(string)
  })
  default = {
    instance_type = "t2.micro"
    ami_id        = "ami-0c55b159cbfafe1f0"
    tags = {
      Environment = "Dev"
      Project     = "Learning"
    }
  }
}

resource "aws_instance" "example" {
  instance_type = var.instance_settings.instance_type
  ami           = var.instance_settings.ami_id
  tags          = var.instance_settings.tags
}
```

### d. The `element` Function

The `element` function retrieves a single element from a list at the specified index.

```hcl
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

resource "aws_subnet" "example" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_blocks[count.index]
  availability_zone = element(var.availability_zones, count.index)
}
```

### e. Other Useful Functions

1. `lookup`: Retrieves the value of a single element from a map, given its key.

```hcl
lookup(var.ami_ids, var.region, "ami-default")
```

2. `concat`: Combines two or more lists.

```hcl
concat(["a", "b"], ["c", "d"])
```

3. `merge`: Combines two or more maps.

```hcl
merge({a="b", c="d"}, {e="f", g="h"})
```

4. `coalesce`: Returns the first non-null value in a list of values.

```hcl
coalesce(var.image_id, data.aws_ami.default.id)
```

## 11. Dynamic Blocks

Dynamic blocks allow you to dynamically construct repeated nested blocks within resource configurations.

```hcl
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

resource "aws_security_group" "example" {
  name = "example"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
```

## 12. Terraform Workspaces

Workspaces allow you to manage multiple environments (e.g., dev, staging, prod) using the same Terraform configuration.

- Create a new workspace: `terraform workspace new dev`
- List workspaces: `terraform workspace list`
- Select a workspace: `terraform workspace select prod`

You can use the current workspace in your configuration:

```hcl
resource "aws_instance" "example" {
  instance_type = terraform.workspace == "prod" ? "t2.medium" : "t2.micro"
  # ...
}
```

Remember to always consult the official Terraform documentation for the most up-to-date and detailed information on these concepts and functions.
