# Stage 1: Build Stage
FROM node:22.6-bookworm as build_root

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Runtime Stage
FROM node:22.6-bookworm

RUN adduser -D -u 1001 appuser

WORKDIR /usr/src/app
COPY --from=build_root /usr/src/app/node_modules ./node_modules
COPY --from=build_root /usr/src/app ./
RUN chown -R appuser:appuser /usr/src/app

RUN ls -Ral /usr/src/app

USER appuser

EXPOSE 3000
CMD ["npm", "start"]
