FROM ruby:2.6.2-alpine

ENV DOCKER true
ENV INSTALL_PATH /app
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV USER docker
ENV NODE_VERSION=10.x

ENV RUN_PACKAGES bash ca-certificates fontconfig git less mariadb-dev nodejs nodejs-npm tzdata 
ENV BUILD_PACKAGES build-base curl curl-dev linux-headers ruby-dev wget

RUN addgroup -g 2000 $USER && \
    adduser -D -h $INSTALL_PATH -u 1000 -G $USER $USER

WORKDIR $INSTALL_PATH

# Bundle install
COPY Gemfile Gemfile.lock ./
RUN apk add --no-cache --update $BUILD_PACKAGES $RUN_PACKAGES \
  && gem install bundler -v '2.0.2' \
  && bundle config --local github.https true \
  && bundle install --without no_docker --jobs 20 --retry 5 \
  && chown -R docker:docker $BUNDLE_PATH \
  && wget --no-check-certificate -q -O - https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh > /tmp/wait-for-it.sh \
  && chown docker:docker /tmp/wait-for-it.sh && chmod a+x /tmp/wait-for-it.sh \
  && wget --no-check-certificate -q -O - https://github.com/dustinblackman/phantomized/releases/download/2.1.1a/dockerized-phantomjs.tar.gz | tar xz -C / \
  && npm config set user 0 \
  && npm install -g phantomjs-prebuilt istanbul \
  && npm cache clean --force \
  && chmod a+x /tmp/wait-for-it.sh \
  && chown -R docker:docker /tmp/wait-for-it.sh \
&& apk del $BUILD_PACKAGES

# precompile assets; use temporary secret token to silence error, real token set at runtime
USER $USER
COPY --chown=docker:docker . .
RUN RAILS_ENV=production DEVISE_SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) SECRET_TOKEN=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1) \
    bundle exec rake assets:precompile

# run microscanner
USER root
ARG AQUA_MICROSCANNER_TOKEN
RUN wget -O /microscanner https://get.aquasec.com/microscanner && \
  chmod +x /microscanner && \
  /microscanner ${AQUA_MICROSCANNER_TOKEN} && \
  rm -rf /microscanner

USER $USER
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
