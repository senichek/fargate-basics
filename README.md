# Flask Fargate Demo

This repository demonstrates deploying a Flask application to **AWS Fargate** using **Docker** and **Amazon ECR**

---

## Prerequisites

- Python 3.9+
- Docker
- AWS CLI configured with credentials
- `curl` (optional, for testing locally)

---

## Local Setup

### 1. Create and activate a Python Virtual Environment (Windows)
```bash
python -m venv .venv
```
```bash
.venv\Scripts\activate
```

### 2. Install libraries
```bash
pip install -r requirements.txt
```

### 3. Run the project
```bash
python app.py
```

## Docker and Fargate

### 1. Build the image and test if it works

```bash
docker build -t fargate-demo .
docker run -p 8080:8080 fargate-demo
curl http://localhost:8080/health
```

### 2. Push the image to AWS ECR

```bash
# Authenticate Docker to ECR
aws ecr get-login-password --region eu-west-1 \
| docker login --username AWS --password-stdin \
<aws-acc-id>.dkr.ecr.eu-west-1.amazonaws.com
```

```bash
# Tag the Docker image
docker tag fargate-demo:latest \
<aws-acc-id>.dkr.ecr.eu-west-1.amazonaws.com/fargate-demo-dev-ecr:latest
```

```bash
# Push the Docker image to ECR
docker push <aws-acc-id>.dkr.ecr.eu-west-1.amazonaws.com/fargate-demo-dev-ecr:latest
```

**Explanations:**
- `aws ecr get-login-password --region eu-west-1`  
  Generates a temporary password for Docker authentication.

- `docker login --username AWS --password-stdin <ECR_URI>`  
  Logs Docker into your ECR repository securely.

- `docker tag <local-image>:<tag> <repository-uri>:<tag>`  
  Tags and prepares your local Docker image for ECR.
  The image must be tagged with the full ECR repository URI.

- `docker push <repository-uri>:<tag>`  
  Uploads your Docker image to ECR.


### What has been done in AWS console:
- create private ECR
- created role called ecsTaskExecutionRole
- created task definition
- created cluster splendid-zebra-d6a4bc
- default VPC and Subnets
- Security Group to allow TCP on port 8080 for my IP


curl http://<public-ip>:8080/health




