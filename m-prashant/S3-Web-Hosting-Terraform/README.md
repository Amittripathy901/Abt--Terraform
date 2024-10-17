This is a small project to showcase how to host a static website in Amazon s3 using Terraform  


Provider Configuration: Specifies AWS and random providers
Bucket Creation: Creates an S3 bucket with a unique name
Public Access: Configures public access to the bucket
Website Configuration: Sets up the bucket for static website hosting
File Uploads: Uploads the index.html and styles.css files to the bucket
Website Endpoint: Outputs the URL of the static website --> http://{your_bucket_name}.s3-website.{region}.amazonaws.com



