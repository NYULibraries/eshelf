FROM ruby:2.3.6

ENV INSTALL_PATH /app

# RUN groupadd -g 2000 docker -r && \
#     useradd -u 1000 -r --no-log-init -m -d $INSTALL_PATH -g docker docker
# USER docker

# Setup working directory
WORKDIR $INSTALL_PATH

# PhantomJS
ENV PHANTOMJS_VERSION 2.1.1
RUN wget --no-check-certificate -q -O - https://cnpmjs.org/mirrors/phantomjs/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 | tar xjC /opt
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

RUN wget --no-check-certificate -q -O - https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /tmp/wait-for-it.sh \
  && chmod a+x /tmp/wait-for-it.sh

# Add github to known_hosts
RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# Install npm
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -yq --no-install-recommends nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install istabul for teaspoon code coverage
RUN npm install -g npm \
  && npm install -g istanbul \
  && npm cache clean --force

# Install gems in cachable way
COPY Gemfile Gemfile.lock ./
RUN bundle config --global github.https true
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy source into container
COPY . .
