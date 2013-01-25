--[[ 在共享字典模块中初始化配置参数，便于程序块之间共享配置参数，读取配置参数 ]]

local configs = ngx.shared.configs
local configs_file = require 'lua/config.lua'

--初始化commands配置
local succ, err, forcible = configs:set('commands', configs_file.commands)
if not succ then
    ngx.log(ngx.INFO, 'set commands err: '..err)
    ngx.exit(500)
end

--初始化apps配置
succ, err, forcible = configs:set('apps', configs_file.apps)
if not succ then
    ngx.log(ngx.INFO, 'set apps err: '..err)
    ngx.exit(500)
end

--初始化patterns配置
succ, err, forcible = configs:set('patterns', configs_file.patterns)
if not succ then
    ngx.log(ngx.INFO, 'set patterns err: '..err)
    ngx.exit(500)
end

--初始化types参数
succ, err, forcible = configs:set('types', configs_file.types)
if not succ then
    ngx.log(ngx.INDO, 'set types err: '..err)
    ngx.exit(500)
end
