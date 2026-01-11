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
else
    ngx.status = 404
    ngx.header.content_type = "application/json"
    ngx.say('{"error":"Not Found","message":"No route configured for this domain"}')
    ngx.exit(404)
end
