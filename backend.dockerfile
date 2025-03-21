FROM node:18-slim

ARG RAILWAY_SERVICE_NAME
ARG RAILWAY_ENVIRONMENT

WORKDIR /home/perplexica

COPY src /home/perplexica/src
COPY tsconfig.json /home/perplexica/
COPY drizzle.config.ts /home/perplexica/
COPY package.json /home/perplexica/
COPY yarn.lock /home/perplexica/
COPY config.base.toml /home/perplexica/config.toml

RUN mkdir /home/perplexica/data
RUN mkdir /home/perplexica/uploads

RUN yarn install --frozen-lockfile --network-timeout 600000
RUN yarn build

CMD ["yarn", "start"]