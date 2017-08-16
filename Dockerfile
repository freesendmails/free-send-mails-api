FROM ruby:2.3-slim
# Instala as nossas dependencias
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

# Seta nosso path
ENV INSTALL_PATH /usr/src/app
# Cria nosso diretório
RUN mkdir -p $INSTALL_PATH
# Seta o nosso path como o diretório principal
WORKDIR $INSTALL_PATH
# Copia o nosso Gemfile para dentro do container
COPY Gemfile $INSTALL_PATH/Gemfile
COPY Gemfile.lock $INSTALL_PATH/Gemfile.lock

# RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without development test

# Copia nosso código para dentro do container
COPY . .
# Roda nosso servidor
CMD ["rails", "server", "-b", "0.0.0.0"]
