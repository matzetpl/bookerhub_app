# Dockerfile
FROM ruby:3.3-slim


# Dockerfile (fragment)
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    bash \
    build-essential git curl ca-certificates \
    libsqlite3-0 libsqlite3-dev \
    libvips \
    libyaml-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /app

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

# Entrypoint
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["bash", "-lc", "bin/rails s -b 0.0.0.0 -p 3000"]


