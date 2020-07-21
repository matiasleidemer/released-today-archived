FROM ruby:2.6.3-slim-stretch

ENV BUNDLER_VERSION=1.17.3

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -qq -y --fix-missing --no-install-recommends \
  build-essential \
  libpq-dev \
  curl \
  git \
  nodejs \
  tzdata

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD Gemfile* $INSTALL_PATH/

ENV BUNDLE_GEMFILE $INSTALL_PATH/Gemfile
ENV BUNDLE_JOBS 2
ENV BUNDLE_PATH /gems

RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle check || bundle install

ADD . $INSTALL_PATH
