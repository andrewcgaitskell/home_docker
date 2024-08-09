FROM python:3.12.4-bookworm
ARG BUILD_ENV_USER
ARG BUILD_ENV_USER_UID
ARG BUILD_ENV_USER_GID
ARG BUILD_ENV_GROUPID
ARG BUILD_ENV_GROUPNAME

ENV ENV_USER=$BUILD_ENV_USER
ENV ENV_USER_UID=$BUILD_ENV_USER_UID
ENV ENV_USER_GID=$BUILD_ENV_USER_GID
ENV ENV_GROUPID=$BUILD_ENV_GROUPID
ENV ENV_GROUPNAME=$BUILD_ENV_GROUPNAME

RUN apt-get update && apt-get -y install vim
RUN apt-get -y install unzip

RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
RUN apt-get update && apt-get install -y mariadb-server galera-4 mariadb-client libmariadb3 mariadb-backup mariadb-common
RUN apt-get install -y libmariadb-dev

WORKDIR /workdir

#RUN echo groupadd --gid ${ENV_USER_GID} ${ENV_USER}
#RUN groupadd --gid ${ENV_USER_GID} ${ENV_USER}
#RUN echo useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USER}
#RUN useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USER}

RUN echo groupadd --gid 1000 jupyter_group
RUN groupadd --gid 1000 jupyter_group
RUN echo useradd --uid 1000 --gid 1000 -m andrewcgaitskell
RUN useradd --uid 1000 --gid 1000 -m andrewcgaitskell

RUN chown -R 1000:1000 /workdir

RUN mkdir /home/andrewcgaitskell/notebooks
#RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /home/andrewcgaitskell/notebooks
RUN chown -R  1000:1000 /home/andrewcgaitskell/notebooks

RUN mkdir /env
#RUN chown ${ENV_USER_UID}:${ENV_USER_GID} /env
RUN chown 1000:1000 /env

#USER ${ENV_USER}
USER 1000:1000

ENV VIRTUAL_ENV=/env
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN /env/bin/python3 -m pip install --upgrade pip
RUN . /env/bin/activate
RUN /env/bin/python3 --version
RUN whereis python3
RUN whereis pip3

COPY requirements.txt /env/requirements.txt
RUN /env/bin/pip3 install -r /env/requirements.txt

RUN /env/bin/pip3 freeze
#COPY . /workdir/.
##RUN ls -R /workdir/

VOLUME /home/andrewcgaitskell/notebooks

EXPOSE 8888

CMD ["jupyter", "notebook", "--notebook-dir=/home/andrewcgaitskell/notebooks",  "--port=8888", "--no-browser", "--ip=0.0.0.0"]

