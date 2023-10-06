FROM ghcr.io/roadrunner-server/roadrunner:2023.2 AS roadrunner
FROM php:8.2-alpine as base

WORKDIR /srv/app
RUN addgroup -g "1000" -S php \
  && adduser --system --gecos "" --ingroup "php" --uid "1000" php \
  && mkdir -p /srv/run \
  && chown php /srv/run \
  && chown php /srv/app \
  && chmod 777 /srv/run

CMD ["/usr/local/bin/rr", "serve"]
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions
RUN install-php-extensions grpc

RUN install-php-extensions \
    @composer \
    bcmath \
    intl \
    opcache \
    opentelemetry \
    pcntl \
    pdo_mysql \
    pdo_sqlite \
    protobuf \
    redis \
    sockets \
    zip

COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr
