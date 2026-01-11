-- Logging helper
local function log_error(message)
    ngx.log(ngx.ERR, "[Router] ", message)
end

local function log_info(message)
    ngx.log(ngx.INFO, "[Router] ", message)
end

-- Route mapping table
local routes = {
    ["sribuhost.com"] = "http://sribuhost_com",
    ["www.sribuhost.com"] = "http://sribuhost_com",
    ["specskita.com"] = "http://specskita_com",
    -- Tambahkan domain lain di sini
}

-- Get host from request
local host = ngx.var.host

-- Find target upstream
local target = routes[host]

if target then
    ngx.var.target_upstream = target
    log_info("Routing " .. host .. " to " .. target)
else
    log_error("No route found for host: " .. host)
    ngx.status = 404
    ngx.header.content_type = "application/json"
    ngx.say('{"error":"Not Found","message":"No route configured for this domain"}')
    ngx.exit(404)
end
