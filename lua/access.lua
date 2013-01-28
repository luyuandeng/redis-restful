--file access.lua

function string:split(sep)
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


--req_args为空时,req_args = {}
function check_args(req_args, conf_args)        
    if #req_args ~= conf_args['args_len'] then
        return false
    end
    
    for i = 1, #req_args['args'] do
        local arg = req_args['args'][i]
        if not req_args[conf_args.name] then 
            return false
        end
    end
    return true
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

-- 检查该app是否已经注册
if not apps:has(uri_splits[0]) then
    ngx.log(ngx.INFO, 'err '..uri_splits[1]..' in uri')
    ngx.exit(400)
end

-- 检查在url中的该类型是否符合要求
if not types:has(uri_splits[1]) then
    ngx.log(ngx.INFO, 'err '..uri_splits[2]..' in uri')
    ngx.exit(400)
end

-- 检查该redis命令是否合法
if not commands:has(uri_splits[#uri_splits]) then
    ngx.log(ngx.INFO, 'err '..uri_splits[#uri_splits]..' in uri')
    ngx.exit(400)
end


-- 检查该url匹配到配置文件中的哪个表达式
for i = 1, #patterns do
    local pattern = string.match(uri, patterns[i]) 
    ngx.log(ngx.INFO, 'matching '..patterns[i])
    if pattern then
        ngx.log(ngx.INFO, 'uri is matched whith '..patterns[i])
        local succ, err, forcble = configs:set('pattern', i)     --记录匹配到的uri，用于content中读取
        if not succ then
            ngx.log(ngx.INFO, 'set pattern err '..err)
            ngx.exit(500)
        end
        break
    end
end

local pattern, flag = ngx.shared:get('pattern')
if not flag == 0 then
    ngx.log(ngx.INFO, 'no pattern match this uri')
    ngx.exit(400)
end

local request_args
if method == 'POST' then
    request_args = ngx.req.get_post_args()
else
    request_args = ngx.req.get_uri_args()
end


-- 检查该请求是否匹配到配置文件中的一个方法
local arg_index = nil
local cmd = uri_splits[#uri_patterns]
local method =  ngx.req.get_method()
for i = 1, #commands[cmd] do
    local arg = commands[cmd][i]
    if method == arg['method'] then
       if check_args(request_args, arg) then
           arg_index = i
           break
       end
    end
end

if not arg_index then
    ngx.log(ngx.INFO, 'error in request args')
    ngx.exit(404)
else
    local succ, err, forcble = configs:set('arg_index', arg_index)
    if not succ then
        ngx.log(ngx.INFO, 'set arg_index error')
        ngx.exit(404)
    end
end
