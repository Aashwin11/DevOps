# Use lightweight Node.js base image
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy all source files
COPY . .

# Expose port
EXPOSE 5000

# Start the server
CMD ["node", "server.js"]