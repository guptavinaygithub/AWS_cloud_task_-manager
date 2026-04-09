High-Availability Cloud-Native Task Manager on AWS

Overview

This project is a full-stack cloud-native task management application designed for high availability, scalability, and secure deployment. It allows users to create, update, and manage tasks efficiently while demonstrating real-world cloud architecture and DevOps practices.

The application is built using Spring Boot for the backend and React for the frontend, and is deployed on AWS using modern infrastructure and automation tools.


---

Features

Create, update, and delete tasks

RESTful API integration

Responsive frontend interface

Cloud-based deployment on AWS

High availability architecture using ECS Fargate

Automated CI/CD pipeline with GitHub Actions



---

Tech Stack

Backend: Java, Spring Boot

Frontend: React.js

Database: MySQL (Amazon RDS)

Cloud: AWS (ECS Fargate, S3, RDS, ALB, ECR, VPC)

DevOps: Docker, Terraform, GitHub Actions

Version Control: Git, GitHub



---

Architecture

The application follows a cloud-native architecture:

Frontend is hosted on Amazon S3

Backend runs on AWS ECS Fargate

Application Load Balancer routes traffic

MySQL database is hosted on Amazon RDS

Infrastructure is provisioned using Terraform

CI/CD pipeline automates build and deployment


Flow: User → S3 (Frontend) → ALB → ECS (Backend) → RDS (Database)


---

Setup and Installation

Prerequisites

Java (JDK 17 or 21)

Node.js and npm

Docker

AWS Account

Terraform



---

Backend Setup

1. Navigate to backend folder


2. Build the project: mvn clean package


3. Run the application: java -jar target/*.jar




---

Frontend Setup

1. Navigate to frontend folder


2. Install dependencies: npm install


3. Start the application: npm start




---

Docker Setup

1. Build Docker image: docker build -t task-manager .


2. Run container: docker run -p 8080:8080 task-manager




---

Deployment

Push Docker image to AWS ECR

Deploy using ECS Fargate

Use Terraform to provision infrastructure

Configure CI/CD using GitHub Actions



---

CI/CD Pipeline

Code pushed to GitHub triggers pipeline

Maven builds the backend

Docker image is created and pushed to ECR

ECS service is updated automatically



---

Future Enhancements

User authentication and authorization

Role-based access control

Monitoring and logging

Auto-scaling and performance optimization
