FROM python:3.12

# Installation of TeXlive, see https://docs.getindico.io/en/stable/installation/latex/
COPY texlive.profile /tmp/
RUN cd /tmp && \
	wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
	tar xvzf install-tl-unx.tar.gz && \
	cd install-tl-*/ && \
	./install-tl --profile /tmp/texlive.profile

ENV INDICO_CONFIG=/indico/etc/indico.conf
ENV INDICO_VERSION=3.3.12
ENV INDICO_UNIPIEVENTS_VERSION=0.3.3

RUN pip3 install indico==${INDICO_VERSION} uwsgi wheel indico-plugins indico-plugin-unipievents==${INDICO_UNIPIEVENTS_VERSION} && \
	apt-get update && apt-get -y install netcat-openbsd git && rm /var/lib/apt/lists -rf && \
	useradd -rm -d /indico -s /bin/bash indico && \
	mkdir /indico/archive && \
	mkdir /indico/cache && \
	mkdir /indico/etc && \
	mkdir /indico/log && \
	mkdir /indico/tmp && \
	mkdir /indico/web && \
        mkdir /custom && \
	chown indico:indico /indico -R && \
        chown indico:indico /custom && \
	su - -c "indico setup create-symlinks /indico" indico && \
	su - -c "indico setup create-logging-config /indico/etc" indico

COPY indico.conf /indico/etc/
COPY uwsgi-indico.ini /indico/
COPY run-indico.sh /indico/

RUN chmod a+x /indico/run-indico.sh

EXPOSE 9090

USER indico
ENTRYPOINT /indico/run-indico.sh
