FROM ruby

RUN apt-get install -y git
RUN mkdir git
WORKDIR git
RUN git clone https://github.com/JohnTendis/artii-api.git
WORKDIR artii-api
RUN bundle update
RUN gem install async-rack
ENV GOLIATH_ENV=development
CMD foreman start
