--[[redis执行函数库]]


-- del ttl pttl exists type get mget  strlen hgetall
-- hlen hkeys hvals llen smembers scard
function (uri_splits, args)
    local keyid = uri_splits[3]
    local cmd = uri_splits[4]
    local ok, err = commands[cmd](keyid, args)
    if not ok then 
        ngx.log(ngx.INFO, 'faild to '..cmd..' '..keyid..': ', err)
        return
    end
    return ok
end

-- getrange  bitcount
function (uri_splits, args) 
    local keyid = uri_splits[3]
    local cmd = uri_splits[4]
    local start = args['start']
    local ended = args['end']
    local ok, err = commands[cmd](keyid, start, ended)
    if not ok then
        ngx.log(ngx.INDO, 'faild to '..cmd..' '..keyid..': '..err)
        return
    end
    return 0k
end

-- getbit 
function (uri_splits, args)
    local keyid = uri_splits[3]
    local cmd = uri_splits[4]
    local offset = args['offset']
    local ok, err = commands[cmd](keyid, offset)
    if not ok then
        ngx.log(ngx.INFO, 'faild to '..cmd..' '..keyid..': '..err)
        return
    end
    return 0k
end

-- hget hdel hexists
function (uri_splits, args)
    local keyid = uri_splits[3]
    local field = uri_splits[5]
    local cmd = uri_splits[6]
    local ok, err = commands[cmd](keyid, filed)
    if not ok then
        ngx.log(ngx.INFO, 'faild to '..cmd..' '.keyid..': '..err)
        return
    end
    return ok
end

--lrange
function (uri_splits, args)
    local keyid = uri_splits[3]
    local cmd = uri_splits[4]
    local start = args['start']
    local stop = args['stop']
    local ok, err = commands[cmd](keyid, start, stop)
    if not ok then
        ngx.log(ngx.INFO, 'faild to '..cmd..' '..keyid..': '..err)
        return 
    end
    return ok
end

--lindex
function (uri_splits, args)
    local keyid = uri_splits[3]
    local cmd = uri_splits[4]
    local index = args['index']
    local ok, err = commands[cmd](keyid, index)
    if not ok then
        ngx.log(ngx.INFO, 'faild to '..cmd..' '..keyid..': '..err)
        return 
    end
    return ok
end

--sismember
function (uri_splits, args)
    local keyid = uri_splits[3]
    local cmd = uri_splits[4]
    local member = args['member']
    
end

function (uri_splits, args)
    local cmd = uri_splits[3]
    local ok, err = commands[cmd](args)
    if not ok then
        ngx.say('faild to '..cmd..': ', err)
        return
    end
    return ok
end

function (uri_splits, args)
    local keyid = uri_splits[3]
    local field = uri_splits[5]
    local cmd = uri_splits[6]
    local ok, err = commands[cmd](keyid, field, args)
    if not ok then
        ngx.say('faild to '..cmd..key..field..': ', err)
        return
    end
    return ok
end

function (uri_splits, args)
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
