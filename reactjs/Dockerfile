FROM node:latest

# Set working directory
WORKDIR /app

RUN mkdir /app/public
RUN mkdir /app/src

# 
COPY package.json /app/package.json

RUN npm install

COPY ./src/ /app/src
COPY ./public/ /app/public

#ENV CI=true
ENV PORT=3000

CMD [ "npm", "start" ]

