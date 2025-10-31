# syntax=docker/dockerfile:1

ARG NODE_VERSION=20.11.1
FROM node:${NODE_VERSION}-alpine AS base

WORKDIR /app

# Install dependencies separately to leverage Docker layer caching
COPY package*.json ./
RUN npm ci

FROM base AS runtime-storybook

# Copy the rest of the source code for Storybook
COPY . .

EXPOSE 6006

# Command to run Storybook in dev mode
CMD ["npm", "run", "storybook", "--", "--host", "0.0.0.0", "--port", "6006"]

FROM base AS runtime-dev

# Copy the rest of the source code for Vite dev server
COPY . .

EXPOSE 5173

# Default command starts the Vite dev server accessible from outside the container
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "5173"]
