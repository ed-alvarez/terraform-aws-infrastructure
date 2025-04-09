# AWS Infrastructure

This project defines a complete cloud infrastructure setup using Terraform and Helm, showcasing best practices in infrastructure-as-code (IaC) for deploying and managing scalable, secure, and resilient cloud environments. The primary goal is to provide a robust foundation for hosting a modern SaaS (Software-as-a-Service) application on AWS.

## Technologies Used

- **Terraform** – Automates the provisioning and management of AWS infrastructure.
- **Helm** – Simplifies deployment of Kubernetes applications and configurations.

## AWS Services Included

- **Amazon EKS with Fargate** – Manages containerized workloads with a serverless Kubernetes engine.
- **Custom VPC** – Provides isolated networking for secure and controlled traffic flow.
- **Amazon RDS** – Manages relational databases with high availability and automated backups.
- **AWS KMS** – Secures sensitive data through managed key encryption.
- **Amazon S3** – Stores application assets, static files, and backups.
- **Amazon Cognito** – Handles user authentication and identity management.
- **ElastiCache (Memcached)** – Speeds up application performance with in-memory caching.
- **AWS Secrets Manager** – Protects sensitive configuration values like API keys and database credentials.

## Usage

1. Clone the repository.
2. Configure your cloud provider credentials.
3. Initialize Terraform:

```sh
terraform init
```

4. Plan and apply the configuration:

```sh
terraform plan
terraform apply
```

## License

This project is for demonstration purposes only.
