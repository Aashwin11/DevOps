[
  {
    "name": "web-api",
    "image": "${web_image_url}",
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "MONGO_URL",
        "value": "$${mongo_url_string}"
      },
      {
        "name": "PORT",
        "value": "5000"
      }
    ],
    "healthCheck": {
      "command": ["CMD-SHELL", "curl -f http://localhost:5000/health || exit 1"],
      "interval": 30,
      "timeout": 5,
      "retries": 3,
      "startPeriod": 10
    },
    "essential": true
  },
  {
    "name": "mongo",
    "image": "${mongo_image}",
    "portMappings": [
      {
        "containerPort": 27017,
        "hostPort": 27017,
        "protocol": "tcp"
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "${efs_mount_name}",
        "containerPath": "/data/db"
      }
    ],
    "essential": true
  }
]
