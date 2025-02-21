FROM node:20.18.0-alpine AS builder

WORKDIR /app

# Set build-time environment variables with defaults
ARG NEXT_PUBLIC_API_URL="http://localhost:3001/api"
ARG NEXT_PUBLIC_WS_URL="ws://localhost:3001"

ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}
ENV NEXT_PUBLIC_WS_URL=${NEXT_PUBLIC_WS_URL}

# Copy package files first for better caching
COPY ui/package.json ui/yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the UI files
COPY ui/ .

# Build Next.js
RUN yarn build

# Debug: Show contents
RUN ls -la .next/standalone

# Production image, copy all the files and run next
FROM node:20.18.0-alpine AS runner

WORKDIR /app

# Set runtime environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Copy necessary files
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone/ ./
COPY --from=builder /app/.next/static/ ./.next/static/

# Debug: Show contents
RUN ls -la

# Expose the port
EXPOSE 3000

# Start the server with environment variables
CMD ["node", "server.js"] 