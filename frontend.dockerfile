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

# Expose the port
EXPOSE 3000

# Set the environment variable for the port
ENV PORT=3000
ENV NODE_ENV=production

# Start the server
CMD ["yarn", "start"] 