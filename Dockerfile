# Prepare the base environment.
FROM ubuntu:20.04 as builder_base_docker
MAINTAINER itadmin@digitalreach.com.au 
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Perth
ENV PRODUCTION_EMAIL=True
ENV SECRET_KEY="ThisisNotRealKey"
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install --no-install-recommends -y  wget git libmagic-dev gcc binutils tzdata vsftpd net-tools 
RUN apt-get install -y vim
# Example Self Signed Cert
RUN apt-get install -y openssl
RUN openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj  "/C=AU/ST=Western Australia/L=Perth/O=Digital Reach Insight/OU=IT Department/CN=example.com"  -keyout /etc/ssl/private/selfsignedssl.key -out /etc/ssl/private/selfsignedssl.crt

# Install Python libs from requirements.txt.
FROM builder_base_docker as ftp_docker
WORKDIR /app
#COPY gunicorn.ini manage.py ./
COPY boot.sh /
#RUN python manage.py collectstatic --noinput
#RUN service rsyslog start
#RUN chmod 0644 /etc/cron.d/dockercron
#RUN crontab /etc/cron.d/dockercron
#RUN touch /var/log/cron.log
#RUN service cron start
RUN chmod 755 /boot.sh
EXPOSE 80
#HEALTHCHECK --interval=1m --timeout=5s --start-period=10s --retries=3 CMD ["wget", "-q", "-O", "-", "http://localhost:8080/"]
HEALTHCHECK --interval=5s --timeout=2s CMD ["netstat -ant","| grep ':21' | wc -l"]
CMD ["/boot.sh"]
