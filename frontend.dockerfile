FROM node:20.18.0-alpine AS builder

WORKDIR /home/perplexica

# Copy package files first for better caching
COPY ui/package.json ui/yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the UI files
COPY ui/ .

# Build Next.js
RUN yarn build

# Production image, copy all the files and run next
FROM node:20.18.0-alpine AS runner

WORKDIR /home/perplexica

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Copy necessary files
COPY --from=builder /home/perplexica/package.json ./package.json
COPY --from=builder /home/perplexica/node_modules ./node_modules
COPY --from=builder /home/perplexica/.next ./.next
COPY --from=builder /home/perplexica/public ./public

# Expose the port
EXPOSE 3000

# Start the server
CMD ["yarn", "start", "-p", "3000"] 