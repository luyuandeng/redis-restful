function string:split(sep)jj
   local sep, fields = sep or ":", {}
   local pattern = string.format("([^%s]+)", sep)
   self:gsub(pattern, function(c) fields[#fields+1] = c end)
   return fields
end


function table:has(str)
    for i = 1, #self do
        if str == self[i] then
            return true
        end
    end
    return false
end


local configs = ngx.shared.configs

local commands, flags = configs:get('commands')
if not flags then
    ngx.log(ngx.INFO, 'err when get commands')
    ngx.exit(500)
end

local patterns, flags = configs:get('patterns')
if not flags then
    ngx.log(ngx.INFO, 'err when get patterns')
    ngx.exit(500)
end

local types, flags = configs:get('types')
if not flags then
    ngx.log(ngx.INFO, 'err when get types')
    ngx.exit(500)
end

local apps, flags = configs:get('apps')
if not flags then
    ngx.log(ngx.INFO, 'err when get apps')
    ngx.exit(500)
end


local uri  = ngx.var.uri
local uri_splits = uri:split('/')

if not apps:has(uri_splits[0]) then
    ngx.log(ngx.INFO, 'err '..uri_splits[1]..' in uri')
    ngx.exit(400)
end
if not types:has(uri_splits[1]) then
    ngx.log(ngx.INFO, 'err '..uri_splits[2]..' in uri')
    ngx.exit(400)
end
if not commands:has(uri_splits[#uri_splits]) then
    ngx.log(ngx.INFO, 'err '..uri_splits[#uri_splits]..' in uri')
    ngx.exit(400)
end

for i = 1, #patterns do
    local pattern = string.match(uri, patterns[i]) 
    ngx.log(ngx.INFO, 'matching '..patterns[i])
    if pattern then
        ngx.log(ngx.INFO, 'uri is matched whith '..patterns[i])
        local succ, err, forcble = configs:set('pattern': i)    --记录匹配到的uri，用于content中读取
        if not succ then
            ngx.log(ngx.INFO, 'set pattern err '..err)
            ngx.exit(500)
        end
    end
end


