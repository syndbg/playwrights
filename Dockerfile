# https://docs.docker.com/compose/rails/
FROM ruby:2.2.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /playwrights

WORKDIR /playwrights

ADD Gemfile /playwrights/Gemfile
RUN gem install bundler
RUN bundle install
ADD . /playwrights
