FROM node:latest

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

# Set working directory
WORKDIR /app
RUN mkdir /app/public
RUN mkdir /app/src

RUN echo groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN echo useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}
RUN useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}

RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /app

USER ${ENV_USER_UID}:${ENV_USER_GID}

COPY package.json /app/package.json

RUN npm install

COPY ./src/ /app/src
COPY ./public/ /app/public

#ENV CI=true
ENV PORT=4000

CMD [ "npm", "start" ]

