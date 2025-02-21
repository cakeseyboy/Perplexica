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

# Start the app
CMD ["yarn", "start"] 