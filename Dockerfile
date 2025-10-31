# syntax=docker/dockerfile:1

ARG NODE_VERSION=20.19.4
FROM node:${NODE_VERSION}-alpine AS base

WORKDIR /app

# Install dependencies separately to leverage Docker layer caching
COPY package*.json ./
RUN npm ci \
  && sha256sum package-lock.json | cut -d' ' -f1 > /app/node_modules/.package-lock.hash

FROM base AS runtime-base

# Copy the rest of the source code and cache node_modules
COPY . .
COPY --from=base /app/node_modules /node_modules_cache
COPY docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh \
  && chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

FROM runtime-base AS runtime-storybook

EXPOSE 6006

# Command to run Storybook in dev mode
CMD ["npm", "run", "storybook", "--", "--host", "0.0.0.0", "--port", "6006"]

FROM runtime-base AS runtime-dev

EXPOSE 5173

# Default command starts the Vite dev server accessible from outside the container
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "5173"]
