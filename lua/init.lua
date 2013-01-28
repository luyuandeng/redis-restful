--[[ 在共享字典模块中初始化配置参数，便于程序块之间共享配置参数，读取配置参数 ]]

package.path = 'lua/?.lua'

local config_dict = ngx.shared.configs
local configs = require 'config'
local prolib = require 'prolib'

--初始化commands配置

local commands = prolib.table.tostring(configs.commands)
local succ, err, forcible = config_dict:set('commands', commands)
if not succ then
    ngx.log(ngx.INFO, 'set commands err: '..err)
    ngx.exit(500)
end

-- test commands 
local commands = config_dict:get('commands')
commands = prolib.table.loadstring(commands)
for a, b in pairs(commands) do
    ngx.log(ngx.INFO, a)
end

--初始化apps配置

local apps = prolib.table.tostring(configs.apps)
succ, err, forcible = config_dict:set('apps', apps)
if not succ then
    ngx.log(ngx.INFO, 'set apps err: '..err)
    ngx.exit(500)
end

--初始化patterns配置
local patterns prolib.table.tostring(configs.patterns)
succ, err, forcible = config_dict:set('patterns', patterns)
if not succ then
    ngx.log(ngx.INFO, 'set patterns err: '..err)
    ngx.exit(500)
end

--初始化types参数
local types = prolib.table.tostring(configs.types)
succ, err, forcible = config_dict:set('types', types)
if not succ then
    ngx.log(ngx.INDO, 'set types err: '..err)
    ngx.exit(500)
end
