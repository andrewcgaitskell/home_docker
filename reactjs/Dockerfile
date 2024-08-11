# Stage 1: Build Stage
FROM node:22.6-bookworm as build_root

WORKDIR /usr/src
#COPY package*.json ./
#RUN npm install
#COPY . .
RUN npm cache clean -f
RUN npm install -g n
RUN n stable
RUN npm install -g npm@10.8.2
RUN npx create-react-app app

# Stage 2: Runtime Stage
FROM node:22.6-bookworm

WORKDIR /usr/src/app
COPY --from=build_root /usr/src/app/node_modules ./node_modules
COPY --from=build_root /usr/src/app ./

#RUN ls -Ral /usr/src/app

#USER node

EXPOSE 3000
CMD ["npm", "start"]
