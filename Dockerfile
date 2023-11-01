FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

RUN cp config/master.key.template config/master.key
RUN rails db:migrate
RUN rails db:seed

CMD ["rails", "server", "-b", "0.0.0.0"]