FROM ruby:2.3
MAINTAINER docker@ipepe.pl

RUN apt-get update && apt-get install -y locales && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale
RUN echo 'LANGUAGE="en_US:en"' >> /etc/default/locale

WORKDIR /app

ENV APP_ENV=production
RUN gem install bundler
COPY app /app
RUN bundle install -j 3 --deployment

EXPOSE 80 22

CMD [ "bundle", "exec", "ruby", "index.rb", "-p 80"]
