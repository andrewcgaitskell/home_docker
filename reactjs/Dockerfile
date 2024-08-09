# syntax=docker/dockerfile:1.4

# 1. For build React app
FROM node:lts AS development

# Set working directory
WORKDIR /app
RUN mkdir /app/public

# 
COPY package.json /app/package.json
# COPY package-lock.json /app/package-lock.json

RUN npm install --package-lock-only url-parse

RUN npm install

# Same as npm install
# RUN npm ci

COPY ./src /app
COPY ./public /app/public

ENV CI=true
ENV PORT=3000

CMD [ "npm", "start" ]

