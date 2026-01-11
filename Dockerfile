FROM openresty/openresty:alpine-fat

# Install dependencies untuk SSL
RUN apk add --no-cache openssl curl bash

# Install lua-resty-auto-ssl
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-auto-ssl

# Buat folder untuk log dan config
RUN mkdir -p /usr/local/openresty/nginx/conf/lua

# Folder untuk menyimpan sertifikat SSL dengan permission yang tepat
RUN mkdir -p /etc/resty-auto-ssl && \
    chown -R nobody:nobody /etc/resty-auto-ssl && \
    chmod 750 /etc/resty-auto-ssl

# Jalankan perintah OpenSSL untuk membuat sertifikat fallback secara otomatis
# Kita tambahkan flag -subj agar tidak muncul pertanyaan interaktif saat build
RUN openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=Development/CN=localhost" \
    -keyout /usr/local/openresty/nginx/conf/fallback.key \
    -out /usr/local/openresty/nginx/conf/fallback.crt

# Set proper permissions untuk OpenResty
RUN chown -R nobody:nobody /usr/local/openresty/nginx/

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost/health || exit 1
