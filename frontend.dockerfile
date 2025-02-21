FROM node:20.18.0-alpine

WORKDIR /home/perplexica

# Copy the UI files
COPY ui /home/perplexica/

# Install dependencies and build
RUN yarn install --frozen-lockfile
RUN yarn build

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

# Expose the port
EXPOSE 3000

# Start the server
CMD ["yarn", "start"] 