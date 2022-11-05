FROM ruby:3.0.1-alpine AS base_image
LABEL maintainer="#niteroomcreation <developadi@gmail.com>"

RUN apk --no-cache add --virtual build-dependencies \
    build-base \
    # Nokogiri Libraries
    zlib-dev \
    libxml2-dev \
    libxslt-dev \
    # Postgres
    postgresql-dev \
    # JavaScript
    nodejs \
    yarn \
    # FFI Bindings in ruby (Run C Commands)
    libffi-dev \
    # Fixes watch file issues with things like HMR
    libnotify-dev


# Rails Specific libraries
RUN apk --no-cache add \
    # ActiveStorage file inspection
    file \
    # Time zone data
    tzdata \
    # HTML to PDF conversion
    # ttf-ubuntu-font-family \
    # wkhtmltopdf \
    # Image Resizing
    imagemagick \
    vips \
    # Nice to have
    bash \
    git \
    # VIM is a handy editor for editing credentials
    vim \
    # Allows for mimemagic gem to be installed
    shared-mime-info

FROM base_image AS development

# Set build args. These let linux users not run into file permission problems
ARG USER_ID=${USER_ID:-1000}
ARG GROUP_ID=${GROUP_ID:-1000}

# Add non-root user and group with alpine first available uid, 1000
RUN addgroup -g $USER_ID -S appgroup \
    && adduser -u $GROUP_ID -S appuser -G appgroup

# Install multiple gems at the same time
RUN bundle config set jobs $(nproc)


RUN mkdir /ror \
    && chown -R appuser:appgroup /ror
WORKDIR /ror

# Define the user running the container
USER appuser


COPY --chown=appuser:appgroup Gemfile /ror/Gemfile
COPY --chown=appuser:appgroup Gemfile.lock /ror/Gemfile.lock

# Install Ruby Gems
RUN bundle install --jobs=$(nproc)

COPY --chown=appuser:appgroup . /ror