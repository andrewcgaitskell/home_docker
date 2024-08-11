# Stage 1: Build Stage
FROM node:18-alpine AS build

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Runtime Stage
FROM node:18-alpine

RUN adduser -D -u 1001 appuser

WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app ./
RUN chown -R appuser:appuser /usr/src/app

USER appuser

EXPOSE 3000
CMD ["npm", "start"]
