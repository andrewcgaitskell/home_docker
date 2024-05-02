FROM node:21-bookworm
## AS development
ENV NODE_ENV development

# Add a work directory
WORKDIR /app

# Cache and Install dependencies
COPY package.json .
#COPY yarn.lock .
COPY package-lock.json .

#RUN yarn install
RUN npm ci

# Copy app files
COPY . .

# Expose port
EXPOSE 4000

ENV PORT=4000
ENV HOST=0.0.0.0
ENV CI=true

# Start the app
CMD [ "npm", "start" ]
