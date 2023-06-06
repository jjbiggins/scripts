#!/bin/bash


docker run --name es01 \
--hostname es01.${HOSTNAME} \
--user=elasticsearch:root \
--env=node.name=es01 \
--env=ELASTIC_PASSWORD="deu=m0IcHQObsU9zZqRK" \
--env=PATH=/usr/share/elasticsearch/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
--env=ELASTIC_CONTAINER=true \
--volume=/srv/docker/elasticsearch/data:/usr/share/elasticsearch/data \
--volume=/srv/docker/elasticsearch/config/certs:/usr/share/elasticsearch/config/certs \
--workdir=/usr/share/elasticsearch -p 9200:9200 -p 9300:9300 \
--label='org.label-schema.build-date=2023-04-27T04:33:42.127815583Z' \
--label='org.label-schema.license=Elastic-License-2.0' \
--label='org.label-schema.name=Elasticsearch' \
--label='org.label-schema.schema-version=1.0' \
--label='org.label-schema.url=https://www.elastic.co/products/elasticsearch' \
--label='org.label-schema.usage=https://www.elastic.co/guide/en/elasticsearch/reference/index.html' \
--label='org.label-schema.vcs-ref=f229ed3f893a515d590d0f39b05f68913e2d9b53' \
--label='org.label-schema.vcs-url=https://github.com/elastic/elasticsearch' \
--label='org.label-schema.vendor=Elastic' \
--label='org.label-schema.version=8.7.1' \
--label='org.opencontainers.image.created=2023-04-27T04:33:42.127815583Z' \
--label='org.opencontainers.image.documentation=https://www.elastic.co/guide/en/elasticsearch/reference/index.html' \
--label='org.opencontainers.image.licenses=Elastic-License-2.0' \
--label='org.opencontainers.image.ref.name=ubuntu' \
--label='org.opencontainers.image.revision=f229ed3f893a515d590d0f39b05f68913e2d9b53' \
--label='org.opencontainers.image.source=https://github.com/elastic/elasticsearch' \
--label='org.opencontainers.image.title=Elasticsearch' \
--label='org.opencontainers.image.url=https://www.elastic.co/products/elasticsearch' \
--label='org.opencontainers.image.vendor=Elastic' \
--label='org.opencontainers.image.version=8.7.1' \
--runtime=runc -d elasticsearch:8.7.1
