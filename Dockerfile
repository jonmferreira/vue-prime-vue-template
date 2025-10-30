# syntax=docker/dockerfile:1

ARG NODE_VERSION=20.11.1
FROM node:${NODE_VERSION}-alpine AS base

WORKDIR /app

# Install dependencies separately to leverage Docker layer caching
COPY package*.json ./
RUN npm ci

# Copy the rest of the source code
COPY . .

EXPOSE 5173

# Default command starts the Vite dev server accessible from outside the container
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "5173"]
