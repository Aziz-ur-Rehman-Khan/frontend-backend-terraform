[
  {
    "name": "backend",
    "image": "${backend_image}",
    "cpu": ${cpu},
    "portMappings": [
      {
        "containerPort": ${port_backend},
        "hostPort": ${port_backend}
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
        "awslogs-group": "/${log_group_prefix}/backend",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "backend"
      }
    }
  }
]
