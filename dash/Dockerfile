FROM python:3.11.4-bullseye

RUN apt-get update && apt-get -y install vim
RUN apt-get -y install unzip

RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
RUN apt-get update && apt-get install -y mariadb-server galera-4 mariadb-client libmariadb3 mariadb-backup mariadb-common
RUN apt-get install -y libmariadb-dev

WORKDIR /workdir

RUN mkdir /env

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
##EXPOSE 8010:8010

CMD ["gunicorn"  , "--bind", "0.0.0.0:8010", "wsgi:application" , "--reload"]
##CMD [ "gunicorn", "wsgi:application", "--reload"]
