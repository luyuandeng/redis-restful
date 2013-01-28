--[[ 在共享字典模块中初始化配置参数，便于程序块之间共享配置参数，读取配置参数 ]]

package.path = 'lua/?.lua'

local config_dict = ngx.shared.configs
local configs = require 'config'

--初始化commands配置
local succ, err, forcible = config_dict:set('commands', configs.commands)
if not succ then
    ngx.log(ngx.INFO, 'set commands err: '..err)
    ngx.exit(500)
end

for a, b in pairs(configs.commands) do
    ngx.log(INFO, a)
end

--初始化apps配置
succ, err, forcible = config_dict:set('apps', configs.apps)
if not succ then
    ngx.log(ngx.INFO, 'set apps err: '..err)
    ngx.exit(500)
end

--初始化patterns配置
succ, err, forcible = config_dict:set('patterns', configs.patterns)
if not succ then
    ngx.log(ngx.INFO, 'set patterns err: '..err)
    ngx.exit(500)
end

--初始化types参数
succ, err, forcible = config_dict:set('types', configs.types)
if not succ then
    ngx.log(ngx.INDO, 'set types err: '..err)
    ngx.exit(500)
end
