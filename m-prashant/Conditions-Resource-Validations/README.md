Conditions Task

• Create EC2 instance

Implement preconditions:

• Inside the resource block, add a lifecycle block.

• Add precondition blocks to ensure that the security_group id is created

Implement postcondition:

• Add another lifecycle block within the resource.

• Add a postcondition block to ensure that the instance has a public IP address after creation.