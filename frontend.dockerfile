FROM node:20.18.0-alpine AS builder

# Set working directory
WORKDIR /home/perplexica

# Copy the UI files
COPY ui /home/perplexica/

# Install dependencies and build
RUN yarn install --frozen-lockfile
RUN yarn build

# Production image, copy all the files and run next
FROM node:20.18.0-alpine AS runner
WORKDIR /home/perplexica

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Copy necessary files
COPY --from=builder /home/perplexica/public ./public
COPY --from=builder /home/perplexica/.next/standalone ./
COPY --from=builder /home/perplexica/.next/static ./.next/static

# Expose the port
EXPOSE 3000

# Start the server
CMD ["node", "server.js"] 