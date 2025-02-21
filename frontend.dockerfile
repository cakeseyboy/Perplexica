FROM node:20.18.0-alpine AS builder

WORKDIR /app

# Copy package files first for better caching
COPY ui/package.json ui/yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the UI files
COPY ui/ .

# Build Next.js
RUN yarn build

# Debug: Show what files are in the standalone directory
RUN ls -la .next/standalone

# Production image, copy all the files and run next
FROM node:20.18.0-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Copy standalone files and static assets
COPY --from=builder /app/.next/standalone/ ./
COPY --from=builder /app/.next/static/ ./.next/static/
COPY --from=builder /app/public/ ./public/

# Debug: Show what files are in the final directory
RUN ls -la

# Expose the port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"] 