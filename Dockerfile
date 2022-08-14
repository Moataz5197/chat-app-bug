FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /chat-app
WORKDIR /chat-app
ADD Gemfile /chat-app/Gemfile
ADD Gemfile.lock /chat-app/Gemfile.lock
RUN gem install bundler:2.0.0.pre.3

RUN gem install mysql2 -v '0.4.10' --source 'https://rubygems.org/'

RUN bundle _2.0.0.pre.3_ install
ADD . /chat-app