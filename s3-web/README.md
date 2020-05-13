# Task

- Create a static website in S3  
- Acceptance Criteria:     
    - bucket is publicly available     
    - created via terraform     
    - bonus: Use https (CloudFront)     
    - bonus: Downloading files through the FE  


## Prerequsites: 

- Terraform server (with access to AWS Account)
    - Access should have the following permissions
        - Create/Edit S3 bucket
        - Create/Edit CloudFront
        - Create/Edit ACM Cert Manager
        - Create/Edit Route53
    - Route 53 Domain Name

## Solution 

- Step 1: Configuring Terraform Server 

    - Install/Configure Terraform (version 12.~) 
    - Make sure Terraform can access AWS Account and has the ability to create above mentioned resources


- Step 2: Write Terraform code 

- Step 3: Run Terrform code 

    - Terraform init
    - Terraform validate
    - Terraform plan
    - Terraform apply

- Step 4: Upload web template to S3 bucket
    - index.html 
    - error.html

## Resources created with the code

1. S3 bucket
    - acl = public-read 
    - bucket permission = (PublicReadGetObject policy)
    - webhosting enabled

2. ACM Cert Manager
    - Public Certificate
    - Validates cert by DNS (Route 53)

3. CloudFront
    - Custom origin from S3 bucket
    - Index.html is default root object
    - Uses default values from AWS
    - ACM is loaded as a SSL cert

3. Route53
    - A record (alias) for CloudFront 
    - ACM cert validation by route53
    - CNAME record for ACM  
