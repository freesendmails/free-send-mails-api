FROM ruby:2.3-slim

RUN apt-get update && apt-get install -y build-essential nodejs

ENV APP_FOLDER /usr/src/app
ENV BUNDLE_JOBS=4

ADD . $APP_FOLDER
WORKDIR $APP_FOLDER

RUN bundle install
