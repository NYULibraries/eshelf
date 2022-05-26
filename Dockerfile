FROM ruby:2.6.10-alpine3.10

ENV DOCKER true
ENV INSTALL_PATH /app
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_BIN=/usr/local/bundle/bin \
    GEM_HOME=/usr/local/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV USER docker
ENV BUNDLER_VERSION='2.1.4'

RUN addgroup -g 1000 -S docker && \
  adduser -u 1000 -S -G docker docker

WORKDIR $INSTALL_PATH
RUN chown docker:docker .

# bundle install
COPY --chown=docker:docker bin/ bin/
COPY --chown=docker:docker Gemfile Gemfile.lock ./
ARG RUN_PACKAGES="ca-certificates fontconfig mariadb-dev nodejs tzdata git"
ARG BUILD_PACKAGES="ruby-dev build-base linux-headers mysql-dev python shared-mime-info"
ARG BUNDLE_WITHOUT="no_docker"
RUN echo $BUNDLE_WITHOUT
RUN apk add --no-cache --update $RUN_PACKAGES $BUILD_PACKAGES \
  && gem install bundler -v $BUNDLER_VERSION \
  && bundle config --local github.https true \
  && bundle install --without $BUNDLE_WITHOUT --jobs 20 --retry 5 \
  && rm -rf /root/.bundle && rm -rf /root/.gem \
  && rm -rf $BUNDLE_PATH/cache \
  && apk del $BUILD_PACKAGES \
  && chown -R docker:docker $BUNDLE_PATH

# precompile assets; use temporary secret token to silence error, real token set at runtime
USER docker
COPY --chown=docker:docker . .
SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN alias genrand='LC_ALL=C tr -dc "[:alnum:]" < /dev/urandom | head -c40' \
  && SECRET_TOKEN=genrand SECRET_KEY_BASE=genrand \
  RAILS_ENV=production bin/rails assets:precompile \
  && unalias genrand

EXPOSE 9292

CMD ["./script/start.sh", "development"]
