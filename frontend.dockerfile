FROM node:18-slim

WORKDIR /app

# Copy package files
COPY ui/package.json ui/yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the frontend code
COPY ui/ .

# Build the Next.js app
RUN yarn build

# Set up the standalone environment
WORKDIR /app/.next/standalone

# Copy standalone files
RUN cp -r /app/.next/static ./.next/static
RUN cp -r /app/public ./public

# Expose the port
EXPOSE 3000

# Set the environment variable for the port
ENV PORT=3000
ENV NODE_ENV=production

# Start the standalone server
CMD ["node", "server.js"] 