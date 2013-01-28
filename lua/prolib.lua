--[[redis执行函数库]]

--module(..., package.seeall)

split = function (uri_splits, args)
    local keyid = uri_args[3]
    local member = uri_args[5]
    local cmd = uri_args[6]
    local ok, err = commands[cmd](keyid, member, args)
    if not ok then
        ngx.say('faild to '..cmd..keyid..member..': ', err)
        return
    end
    return ok
end

table.tostring = function(t)
    local mark = {}
    local assign = {}
    local function ser_table(tb1, parent)
        mark[tb1] = parent
        local tmp = {}
        for k, v in pairs(tb1) do
            local key = type(k) == "number" and "["..k.."]" or "["..string.format("%q", k).."]"
            if type(v) == 'table' then
                local dotkey = parent..key
                if mark[v] then
                    table.insert(assign, dotkey.."="..mark[v].."\"")
                else
                    table.insert(tmp, key.."="..ser_table(v, dotkey))
                end
            elseif type(v) == "string" then
                table.insert(tmp, key.."="..string.format("%q", v))
            elseif type(v) == "number" or type(v) == "boolean" then
                table.insert(tmp, key.."="..tostring(v))
            end
        end
        return "{"..table.concat(tmp, ',').."}"
    end
    return "do local ret="..ser_table(t, 'ret')..table.concat(assign, " ").."return ret end"
end

table.loadstring = function(strData)
    local f = loadstring(strData)
    if f then
        return f()
    end
end
