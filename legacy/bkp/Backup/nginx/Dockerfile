FROM nginx:1.25-alpine

RUN apk add --no-cache openssl

COPY conf.d/ipa.conf /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.d/10-generate-cert.sh /docker-entrypoint.d/10-generate-cert.sh

RUN chmod +x /docker-entrypoint.d/10-generate-cert.sh
