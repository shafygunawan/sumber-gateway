FROM openresty/openresty:alpine-fat

# Install dependencies untuk SSL
RUN apk add --no-cache openssl curl bash

# Install lua-resty-auto-ssl
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-auto-ssl

# Folder untuk menyimpan sertifikat SSL dengan permission yang tepat
RUN mkdir -p /etc/resty-auto-ssl && \
    chown -R nobody:nobody /etc/resty-auto-ssl && \
    chmod 750 /etc/resty-auto-ssl

# Jalankan perintah OpenSSL untuk membuat sertifikat fallback secara otomatis
# Kita tambahkan flag -subj agar tidak muncul pertanyaan interaktif saat build
RUN openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
        -subj '/CN=sni-support-required-for-valid-ssl' \
        -keyout /etc/ssl/resty-auto-ssl-fallback.key \
        -out /etc/ssl/resty-auto-ssl-fallback.crt
