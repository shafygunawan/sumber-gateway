FROM openresty/openresty:alpine-fat

# Buat folder untuk log dan config
RUN mkdir -p /usr/local/openresty/nginx/conf/lua

# Jalankan perintah OpenSSL untuk membuat sertifikat fallback secara otomatis
# Kita tambahkan flag -subj agar tidak muncul pertanyaan interaktif saat build
RUN openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=Development/CN=localhost" \
    -keyout /usr/local/openresty/nginx/conf/fallback.key \
    -out /usr/local/openresty/nginx/conf/fallback.crt

# Install dependencies untuk SSL
RUN apk add --no-cache openssl curl
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-auto-ssl

# Folder untuk menyimpan sertifikat SSL
RUN mkdir -p /etc/resty-auto-ssl && chown -R nobody:nobody /etc/resty-auto-ssl
