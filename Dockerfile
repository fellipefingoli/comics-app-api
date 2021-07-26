FROM ruby:2.7.3
ARG APP_PATH
ARG RAILS_PORT

RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends \
    build-essential \
    git \
    nodejs \
    libpq-dev \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
COPY Gemfile ./
RUN gem install bundler
RUN bundle install
COPY . .
VOLUME ["$APP_PATH/public"]
EXPOSE $RAILS_PORT
