FROM ruby:2.4-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs

ENV RAILS_ENV production
ENV MAILGUN_SMTP_SERVER replaceme
ENV MAILGUN_SMTP_PORT replaceme
ENV MAILGUN_DOMAIN replaceme
ENV MAILGUN_SMTP_LOGIN replaceme
ENV MAILGUN_SMTP_PASSWORD replaceme
ENV RAILS_LOG_TO_STDOUT true
ENV SECRET_KEY_BASE replaceme
RUN echo 'gem: --no-document' > /etc/gemrc

ENV INSTALL_PATH /usr/src/app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile $INSTALL_PATH/Gemfile
COPY Gemfile.lock $INSTALL_PATH/Gemfile.lock
RUN bundle install --without development test
COPY . .
CMD puma -C config/puma.rb
