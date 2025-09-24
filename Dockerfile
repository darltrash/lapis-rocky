FROM openresty/openresty:rocky

LABEL maintainer="Landon Manning <lmanning17@gmail.com>"

# Build Args
ARG OPENSSL_DIR="/usr/local/openresty/openssl"

# Environment
ENV LAPIS_ENV="production"

# Prepare volumes
VOLUME /var/data
VOLUME /var/www

# Install from Yum
RUN yum -y install \
    epel-release \
    gcc \
    openresty-openssl-devel \
    openssl-devel \
    sqlite-devel \
    git \
    ; yum clean all

RUN yum config-manager --set-enabled powertools

# Install from LuaRocks
RUN luarocks install luasec
RUN luarocks install bcrypt
RUN luarocks install busted
RUN luarocks install i18n
RUN luarocks install lapis \
    CRYPTO_DIR=${OPENSSL_DIR} \
    CRYPTO_INCDIR=${OPENSSL_DIR}/include \
    OPENSSL_DIR=${OPENSSL_DIR} \
    OPENSSL_INCDIR=${OPENSSL_DIR}/include
RUN luarocks install lsqlite3 0.9-1
RUN luarocks install luacov
RUN luarocks install mailgun
RUN luarocks install markdown
RUN luarocks install moonscript
RUN luarocks install lua-cjson

# Entrypoint
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Standard web port (use a reverse proxy for SSL)
EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
