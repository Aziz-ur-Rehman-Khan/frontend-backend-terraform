[
  {
    "name": "frontend",
    "image": "${frontend_image}",
    "cpu": ${cpu},
    "portMappings": [
      {
        "containerPort": ${port_frontend},
        "hostPort": ${port_frontend}
      }
    ],
    "essential": true,
    "command": [
      "npm",
      "start"
    ],
    "environment": [
      {
        "name": "NODE_ENV",
        "value": "production"
      }
    ],
    "secrets": [
      {
        "name": "DATABASE_URL",
        "valueFrom": "${secrets["database_url"]}"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "/${log_group_prefix}/frontend",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "frontend"
      }
    }
  }
]
