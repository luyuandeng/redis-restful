local redis = require "resty.redis"
local cjson = require "cjson"
local red = redis:new()
red:set_timeout(1000)       -- 1 sec
local ok, err = red:connect('127.0.0.1',6379);
if not ok then
    ngx.say('failed to connect', err)
    return
end

local _M = loadfile('lua/commands.lua')()
local commands = {}

for i = 1, #_M do
    local cmd = _M[i]
    commands[cmd] = 
        function (...) 
            return red[cmd](red,...)
        end
end

--ngx.say(ngx.crc32_long(ngx.now()))

function string:split(sep)
   local sep, fields = sep or ":", {}
   local pattern = string.format("([^%s]+)", sep)
   self:gsub(pattern, function(c) fields[#fields+1] = c end)
   return fields
end


function get_body_args()
    local method = ngx.req.get_method()
    if method == 'POST' then
        body_args = ngx.req.get_post_args()
    elseif method == 'GET' then
        body_args = ngx.req.get_uri_args()
    else
        ngx.exit(405)
    end
    return body_args
end


function struct_args(args)                --包装命令和参数
    local str_args = {}
    for i = 1, #args do
        str_args[#str_args + 1] = '\''..args[i]..'\''
    end
    local args_string = "return "..str_args[1]
    for i = 2, #str_args do
        args_string = args_string..','..str_args[i]
    end
    return args_string
end
    

function clean_args(args)
    local clean_field = {}
    for k, v in pairs(args) do
        clean_field[#clean_field +1] = v
    end
    return clean_field
end


local uri = ngx.var.uri
local uri_args = uri:split('/')
for i = 1, #uri_args do
    ngx.say(uri_args[i])
end

local pattern_index = parse_uri()
if not pattern_index then
    ngx.say('can not pattern')
    ngx.say(pattern_index)
else
    ngx.say(pattern_index)
end

ngx.exit(200)

local body_args = clean_args(get_body_args())
local args_string = struct_args(body_args)


ngx.say(cmd..' '..ok)

local ok, err = red:set_keepalive(10000,100)
if not ok then
    ngx.say('failed to set keepalive: ', err)
    return
end
