FROM python:3.9

ENV INDICO_CONFIG=/indico/etc/indico.conf
ENV INDICO_VERSION=3.1

RUN pip3 install indico==${INDICO_VERSION} uwsgi wheel && \
	apt-get update && apt-get -y install netcat && rm /var/lib/apt/lists -rf && \
	useradd -rm -d /indico -s /bin/bash indico && \
	mkdir /indico/archive && \
	mkdir /indico/cache && \
	mkdir /indico/etc && \
	mkdir /indico/log && \
	mkdir /indico/tmp && \
	mkdir /indico/web && \
	chown indico:indico /indico -R && \
	su - -c "indico setup create-symlinks /indico" indico && \
	su - -c "indico setup create-logging-config /indico/etc" indico

COPY indico.conf /indico/etc/
COPY uwsgi-indico.ini /indico/
COPY run-indico.sh /indico/

RUN chmod a+x /indico/run-indico.sh

EXPOSE 9090

USER indico
ENTRYPOINT /indico/run-indico.sh
