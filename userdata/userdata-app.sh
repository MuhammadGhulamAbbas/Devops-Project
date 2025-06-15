#!/bin/bash

# Update system
yum update -y

# Enable Amazon Linux extras for nginx
amazon-linux-extras enable nginx1 -y
yum install -y nginx docker git

# Start Docker properly
systemctl enable docker --now
usermod -aG docker ec2-user

# Clone your React app
cd /home/ec2-user
git clone https://github.com/MARN121/reactapp-devops.git
chown -R ec2-user:ec2-user reactapp-devops
cd reactapp-devops

# Build Docker image
docker build -t reactapp .

# Run the container on internal port
docker run -d -p 3000:80 reactapp

# Set up NGINX reverse proxy to route ALB port 80 to internal 3000
cat <<EOF > /etc/nginx/conf.d/reactapp.conf
server {
    listen 80;
    server_name app.nendo.fun;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Validate and start NGINX after config is placed
nginx -t && systemctl enable nginx --now && systemctl restart nginx
