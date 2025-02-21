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

# Create standalone directory
RUN mkdir -p /app/.next/standalone
RUN cp -r /app/.next/static /app/.next/standalone/.next/
RUN cp -r /app/public /app/.next/standalone/
RUN cp -r /app/.next/standalone/* /app/

# Expose the port
EXPOSE 3000

# Set the environment variables
ENV PORT=3000
ENV NODE_ENV=production
ENV HOSTNAME=0.0.0.0

# Start the server using the standalone output
CMD ["node", "server.js"] 