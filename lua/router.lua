local host = ngx.var.host
local target = ""

if host == "sribuhost.com" or host == "www.sribuhost.com" then
    target = "http://sribuhost_com"
else
    ngx.exit(404)
end

ngx.var.target_upstream = target
