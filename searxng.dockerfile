FROM searxng/searxng:latest

ARG RAILWAY_SERVICE_NAME
ARG RAILWAY_PUBLIC_DOMAIN

COPY searxng/settings.yml /etc/searxng/settings.yml

# Railway will automatically provide RAILWAY_PUBLIC_DOMAIN
ENV INSTANCE_NAME=perplexica-searxng

EXPOSE 8080 