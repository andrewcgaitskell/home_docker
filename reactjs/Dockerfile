# syntax=docker/dockerfile:1.4

# 1. For build React app
FROM node:lts AS development

# Set working directory
WORKDIR /app

RUN mkdir /app/public
RUN mkdir /app/src

# 
COPY package.json /app/package.json
# COPY package-lock.json /app/package-lock.json

RUN npm install --package-lock-only url-parse

RUN npm install

# Same as npm install
# RUN npm ci

COPY ./src /app/src
COPY ./public /app/public

ENV CI=true
ENV PORT=3000

CMD [ "npm", "start" ]

