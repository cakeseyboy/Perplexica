FROM node:18-slim AS builder

WORKDIR /app

# Copy package files
COPY ui/package.json ui/yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the frontend code
COPY ui/ .

# Build the Next.js app
RUN yarn build

# Production image, copy all the files and run next
FROM node:18-slim AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Create required directories
RUN mkdir -p /app/public /app/.next/static

# Copy necessary files from builder
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/.next/standalone/. ./

# Expose the port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"] 