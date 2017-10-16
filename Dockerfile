FROM ruby:2.3-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs

ENV APP_FOLDER /usr/src/app

ADD . $APP_FOLDER
WORKDIR $APP_FOLDER

RUN bundle install
