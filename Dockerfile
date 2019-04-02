FROM quay.io/nyulibraries/selenium_chrome_headless_ruby:2.6-slim-chrome_73

ENV DOCKER true
ENV INSTALL_PATH /app
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV USER docker
ENV NODE_VERSION="10.x"

RUN groupadd -g 2000 $USER -r && \
  useradd -u 1000 -r --no-log-init -m -d $INSTALL_PATH -g $USER $USER

WORKDIR $INSTALL_PATH

COPY bin/ bin/
COPY Gemfile Gemfile.lock ./
ARG RUN_PACKAGES="curl ruby-mysql2 default-libmysqlclient-dev git"
ARG BUILD_PACKAGES="build-essential zlib1g-dev"
RUN apt-get update && apt-get -y --no-install-recommends install $BUILD_PACKAGES $RUN_PACKAGES \
  && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash \
  && apt-get update && apt-get -y --no-install-recommends install nodejs \
  && gem install bundler -v '2.0.1' \
  && bundle config --local github.https true \
  && bundle install --without no_docker --jobs 20 --retry 5 \
  && wget --no-check-certificate -q -O - https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /tmp/wait-for-it.sh \
  && chown docker:docker /tmp/wait-for-it.sh && chmod a+x /tmp/wait-for-it.sh \
  && rm -rf /root/.bundle && rm -rf /root/.gem \
  && rm -rf $BUNDLE_PATH/cache \
  && apt-get --purge -y autoremove $BUILD_PACKAGES \
  && apt-get clean && rm -rf /var/lib/apt/lists/* \
  && chown -R docker:docker $BUNDLE_PATH

# RUN chown docker:docker .

# Install istabul for teaspoon code coverage
RUN npm install -g npm \
  && npm install -g istanbul \
  && npm cache clean --force

# USER $USER

COPY --chown=docker:docker . .
# RUN bundle exec rake assets:precompile

# CMD bundle exec rake
