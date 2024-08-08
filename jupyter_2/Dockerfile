FROM ubuntu:latest

RUN apt-get update && apt-get install -y python-pip

RUN pip install --upgrade pip && pip install jupyter pandas numpy

RUN useradd -r -g users A && \
mkdir /myhome && \
chown -R A:users /myhome

EXPOSE 8888

WORKDIR /myhome

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0"]

