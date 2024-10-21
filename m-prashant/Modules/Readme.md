Terraform Moudles:
Terraform modules are containers for multiple resources that are used together. A module consists of collection of 
.tf and/or .tf.json files kept together in a directory. Modules are the main way to package and reuse resource configurations with Terraform.

Module Structure:
module_name/
│
├── main.tf         # Main configuration files
├── variables.tf    # Input variables
├── outputs.tf      # Output values
└── README.md       # Documentation  


Best Practices for Modules

1.Keep modules focused on a specific task
2.Use consistent naming conventions
3.Provide clear documentation in README.md
4.Use variables for all customizable values
5.Output all necessary data for downstream use
6.Version your modules
7.Test modules thoroughly  