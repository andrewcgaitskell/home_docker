FROM node:22.6-bookworm
RUN apt-get update
//RUN apt-get -y install curl gnupg
//RUN curl -sL https://deb.nodesource.com/setup_20.x  | bash -
//RUN apt-get -y install nodejs

# Add a work directory
WORKDIR /app

# Cache and Install dependencies
COPY package.json .
#COPY yarn.lock .
#COPY package-lock.json .
RUN npm install --package-lock-only url-parse

#RUN yarn install
RUN npm i
RUN npm install mqtt --save

# Copy app files
COPY . .

# Expose port
EXPOSE 4002

ENV PORT=4002
ENV HOST=0.0.0.0
ENV CI=true

# Start the app
CMD [ "npm", "start" ]
