FROM ruby:2.3-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs

RUN echo 'gem: --no-document' > /etc/gemrc

ENV INSTALL_PATH /usr/src/app
RUN mkdir -p $INSTALL_PATH

ADD . $INSTALL_PATH
WORKDIR $INSTALL_PATH

RUN bundle install
