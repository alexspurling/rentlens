# Use a Node.js base image
FROM node:20-slim AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Use a smaller image for production
FROM node:20-slim

WORKDIR /app

# Copy the build artifacts from the builder stage
# SvelteKit with adapter-node builds to the 'build' directory by default
COPY --from=builder /app/build ./build
COPY --from=builder /app/package*.json ./

# Install only production dependencies
RUN npm install --omit=dev

# GCP Cloud Run expects the app to listen on the port defined by the PORT environment variable
ENV PORT=8080
EXPOSE 8080

# Start the application
CMD ["node", "build/index.js"]
