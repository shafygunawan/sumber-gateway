# Sumber Gateway

API Gateway dengan auto SSL (Let's Encrypt), dynamic routing, rate limiting, dan security headers.

## Features

-   ✅ Auto SSL certificates dengan Let's Encrypt
-   ✅ Dynamic routing tanpa restart
-   ✅ Rate limiting untuk mencegah abuse
-   ✅ Security headers (X-Frame-Options, X-XSS-Protection, dll)
-   ✅ Health check endpoint
-   ✅ Proper error handling dan logging
-   ✅ Docker support dengan health checks

## Installation

1. Clone the repository:
    ```bash
    git clone sumber-gateway
    ```
2. Navigate to the project directory:
    ```bash
    cd sumber-gateway
    ```
3. Run the setup script to create the Docker network & start docker containers:
    ```bash
    ./setup.sh
    ```
4. Verify gateway is running:
    ```bash
    curl http://localhost/health
    ```

## Add New Host/Domain

### 1. Tambahkan domain ke whitelist SSL

Edit `conf.d/default.conf`, tambahkan domain ke `allowed_domains`:

```lua
local allowed_domains = {
    ["sribuhost.com"] = true,
    ["www.sribuhost.com"] = true,
    ["domain-baru.com"] = true,  -- tambahkan di sini
}
```

### 2. Tambahkan routing

Edit `lua/router.lua`, tambahkan ke tabel `routes`:

```lua
local routes = {
    ["sribuhost.com"] = "http://sribuhost_com",
    ["www.sribuhost.com"] = "http://sribuhost_com",
    ["domain-baru.com"] = "http://service_baru",  -- tambahkan di sini
}
```

### 3. Reload gateway

```bash
docker compose restart gateway
```

_Note: Ensure your new target service is running and accessible within the Docker network (sumber-network)._

## Monitoring

-   **Health check**: `http://your-server/health`
-   **Docker health**: `docker ps` (lihat status HEALTH)
-   **Logs**: `docker compose logs -f gateway`

## Security Features

-   Domain whitelist untuk SSL certificates
-   Rate limiting: 10 req/s dengan burst 20
-   Security headers otomatis
-   TLS 1.2+ only
-   Proper proxy headers dan timeouts
