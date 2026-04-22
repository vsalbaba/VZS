FROM ubuntu:12.04

# Fix apt sources — Ubuntu 12.04 is EOL, repos moved to old-releases
RUN sed -i 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# System dependencies for Ruby, native gems, and the app
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    git \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    libsqlite3-dev \
    libmysqlclient-dev \
    imagemagick \
    libmagickwand-dev \
    nodejs \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Generate UTF-8 locale — Ruby 1.9.2 gem commands fail without it
RUN locale-gen en_US.UTF-8

# Build Ruby 1.9.2-p330 from source
RUN curl -fsSL https://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.2-p330.tar.gz -o /tmp/ruby.tar.gz && \
    cd /tmp && tar xzf ruby.tar.gz && \
    cd ruby-1.9.2-p330 && \
    ./configure --prefix=/usr/local --disable-install-doc && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /tmp/ruby*

# Fix encoding for Ruby 1.9.2 gem/bundler commands
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

# Bundler 1.17.3 — last 1.x release, compatible with this Gemfile.lock
RUN gem install bundler -v 1.17.3 --no-ri --no-rdoc

ENV BUNDLE_WITHOUT=deploy

WORKDIR /app

# Copy dependency files first for Docker layer caching
COPY Gemfile Gemfile.lock ./

# RubyGems 1.3.7 (shipped with Ruby 1.9.2) uses the Syck YAML engine to
# serialize gemspecs. Syck corrupts "~>" version operators into
# "#<Syck::DefaultKey:0x...>" objects, making Bundler unable to find gems.
# The sed pass restores the correct operator after installation.
RUN bundle install --jobs "$(nproc)" && \
    sed -i 's/#<Syck::DefaultKey:0x[0-9a-f]*>/~>/g' /usr/local/lib/ruby/gems/1.9.1/specifications/*.gemspec

# Copy application code
COPY . .

# Create database.yml from the example template
RUN cp config/database.example.yml config/database.yml

# Prepare the database — hide spec/factories during setup to prevent
# factory_girl_rails from loading User model before tables exist
RUN mv spec/factories /tmp/_factories 2>/dev/null; \
    bundle exec rake db:create db:schema:load db:seed RAILS_ENV=development 2>&1; \
    mv /tmp/_factories spec/factories 2>/dev/null; \
    true

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
