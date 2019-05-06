FROM phusion/passenger-ruby23
MAINTAINER docker@ipepe.pl

ENV PASSENGER_APP_ENV=production

RUN rm -f /etc/service/nginx/down

WORKDIR /home/app

COPY --chown=app:app app/weblab-public /home/app/weblab-public
COPY --chown=app:app app/weblab-api /home/app/weblab-api

USER app
RUN mkdir -p /home/app/weblab-api/public /home/app/weblab-api/tmp \
             /home/app/weblab-public/public /home/app/weblab-public/tmp
RUN cd weblab-public && bundle install -j 3 --deployment
RUN cd weblab-api && bundle install -j 3 --deployment

USER root
RUN rm /etc/nginx/sites-enabled/default
ADD app/nginx-configs/ /etc/nginx/sites-enabled/

EXPOSE 80 8080
