FROM node:22.6-bookworm
## AS development
ENV NODE_ENV development

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package.json .

USER node

RUN npm ci
RUN npm install --package-lock-only url-parse

COPY --chown=node:node . .

EXPOSE 4000

ENV PORT=4000
ENV HOST=0.0.0.0
ENV CI=true

CMD [ "node", "start" ]
###



# Cache and Install dependencies
#COPY package.json .
#COPY yarn.lock .
#COPY package-lock.json .
npm install --package-lock-only url-parse

#RUN yarn install
#RUN npm ci

# Copy app files
#COPY . .

# Expose port
#EXPOSE 4000

#ENV PORT=4000
#ENV HOST=0.0.0.0
#ENV CI=true

# Start the app
#CMD [ "npm", "start" ]
