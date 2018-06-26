FROM ruby:2.3.6

ENV INSTALL_PATH /app

# RUN groupadd -g 2000 docker -r && \
#     useradd -u 1000 -r --no-log-init -m -d $INSTALL_PATH -g docker docker
# USER docker

# Setup working directory
WORKDIR $INSTALL_PATH

RUN wget --no-check-certificate -q -O - https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /tmp/wait-for-it.sh
RUN chmod a+x /tmp/wait-for-it.sh

# Add github to known_hosts
RUN mkdir -p ~/.ssh
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# Install gems in cachable way
COPY Gemfile Gemfile.lock ./
RUN bundle config --global github.https true
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy source into container
COPY . .
