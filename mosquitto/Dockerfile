from eclipse-mosquitto:latest

WORKDIR .

EXPOSE 1883:1883 8080:8080

#RUN cd /etc/mosquitto
#RUN echo "" > mosquitto.pwd
#RUN mosquitto_passwd -b mosquitto.pwd usertest passwordtest
#RUN echo "password_file /etc/mosquitto/mosquitto.pwd" >> mosquitto.conf
#RUN echo "allow_anonymous false" >> /etc/mosquitto/mosquitto.conf

COPY ./config/mosquitto.conf /etc/mosquitto/mosquitto.conf

CMD ["mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]
