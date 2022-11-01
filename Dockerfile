# Supported tags and respective Dockerfile links, 17-alpine3.14, 17.4-alpine3.14, 17.4.0-alpine3.14, alpine3.14, current-alpine3.14
FROM node:16-alpine AS builder

USER node

# Set working directory
WORKDIR /app

# Copy package.json and yarn.json with correct user permission
COPY --chown=node:node package.json yarn.lock ./

# Installing dependencies
RUN yarn install --frozen-lockfile

# Copy project file and folders to the current working directory (i.e. 'app' folder)
COPY --chown=node:node . ./


FROM builder as production
ENV NODE_ENV production
ENV PORT 3000
ENV NEXT_TELEMETRY_DISABLED 1

# Expose the port the app runs in (3000)
EXPOSE 3000

# Building app
RUN yarn build

# Running the app
ENTRYPOINT ["yarn", "start"]