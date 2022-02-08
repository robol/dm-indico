all: indico-web.stamp

indico-web.stamp: Dockerfile indico.conf run-indico.sh uwsgi-indico.ini texlive.profile
	sudo docker build -t robol/indico-web .
	touch indico-web.stamp
