# otel-php + roadrunner stress test

## Usage

```shell
docker compose build
docker compose run php composer update
docker compose up -d php
docker compose run ab -n 1000000 -c 5 http://php:8080/
```
