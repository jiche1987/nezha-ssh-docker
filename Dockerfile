
FROM node:latest

# Expose port 3000
EXPOSE 3000

# Set working directory to /app
WORKDIR /app

# Copy files from host to /app directory
COPY files/* /app/

# Update package repositories and install necessary packages
RUN apt-get update &&\
    apt-get install -y iproute2

# Install package dependencies
RUN npm install

# Install pm2 globally
RUN npm install -g pm2

# Download and install cloudflared
RUN wget -O cloudflared.deb \
    https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    dpkg -i cloudflared.deb &&\
    rm -f cloudflared.deb

# Change the permission of web.js to make it executable
RUN chmod +x web.js

# Set the entrypoint to run node with the server.js file
ENTRYPOINT [ "node", "server.js" ]
