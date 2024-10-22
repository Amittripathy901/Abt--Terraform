AWS IAM Management using Terraform:

1.Provide user and roles info via YAML file
2.Read the YAML file and process data
3.Create IAM Users
4.Generate Password for the Users.
5.Attach Policy/Roles to each User.


users:
  - username: Baburao
    role: AdministratorAccess
  - username: Raju
    role: AmazonS3ReadOnlyAccess
  - username: Shyam
    role: AmazonEC2FullAccess->


    "flatten" function --> is a function in terraform is used to transform a list of list into a single, flat list.