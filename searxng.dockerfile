FROM searxng/searxng:latest

COPY searxng/settings.yml /etc/searxng/settings.yml

# Railway will automatically provide RAILWAY_PUBLIC_DOMAIN
ENV INSTANCE_NAME=perplexica-searxng

EXPOSE 8080 