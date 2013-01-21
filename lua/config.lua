--file config.lua

module(...)

servers =
{
    {
    name='server1',
    host='127.0.0.1',
    port=6379,
    db=0
    },
    {
    name='server2',
    host='127.0.0.1',
    port=6379,
    db=0
    }
}

apps = 
{
    'appid', 
    'default'
}

types = 
{
    'key',
    'keys'
}

patterns = 
{
    '^/%w+/key/[^/]+/%w+$',
    '^/%w+/keys/%w+$',
    '^/%w+/key/[^/]+/field/[^/]+/%w+$',
    '^/%w+/key/[^/]+/member/[^/]+/%w+$'
}

commands = {
    --[[key]]                         
    --删除一个或者多个key
    del = {
        { 
            method = 'POST',
            args_len = 
            args = {
                {
                name =  
                sepatate = true,
                }
            }
        },
        {
            method = 'GET',
            args_len =  
            args = {
                name = 
                sepatate = 
            }
        }
    },
    renamenx = {
        method = {'POST'},
        args_len = 1,
        args = {'newkey'}
    },
    exists = {
        method = {'GET'},
        args_len = 0,
        args = {}
    }, 
    expire = {
        method = {'POST'},
        args_len = 1,
        args = {'seconds'}
    },       
    pexpire = {
        method = {'POST'},
        args_len = 1,
        args = {'milliseconds'}
    },
    randomkey = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    ttl = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },   
    pttl = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    expireat = {
        method = {'post'},
        args_len = 1,
        args = {'timestamp'}
    }, 
    pexpireat = {
        method = {'POST'},
        args_len = 1,
        args = {'milliseconds_timestamp'}
    },
    persist = {
        method = {'POST'},
        args_len = 0,
        args = {}
    },
    rename = {
        method = {'POST'},
        args_len = 1,
        args = {'newkey'}
    },     
    type = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    dump = {
        method = {'POST'},
        args_len = 0,
        args = {}
    },
    restore = {
        methdo = {'POST'},
        args_len = 2,
        args = {'ttl', 'serialized-value'}
    },
    
    --[[string]]          
    append = {
        method = {'POST'},
        args_len = 1,
        args = {'value'}
    },
    getbit = {
        method = {'GET'},
        args_len = 1,
        args = {'offset'}
    },
    mget = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    setex = {
        method = {'POST'},
        args_len = 2,
        args = {'seconds', 'value'}
    },
    psetex = {
        method = {'POST'},
        args_len = 2,
        args = {'milliseconds', 'value'}
    },
    getrange = {
        method = {'GET'},
        args_len = 2,
        args = {'start', 'end'}
    },
    mset = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    setnx = {
        method = {'POST'},
        args_len = 1,
        args = {'value'}
    },
    getset = {
        method = {'POST'},
        args_len = 1,
        args = {'value'}
    },
    msetnx = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    setrange = {
        method = {'POST'},
        args_len = 2,
        args = {'offset', 'value'}
    },
    decr = {
        method = {'POST'},
        args_len = 0,
        args = {}
    },
    incr = {
        method = {'POST'},
        args_len = 0,
        args = {}
    },
    strlen = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    decrby = {
        method = {'POST'},
        args_len = 1,
        args = {'decrement'}
    },
    incrby = {
        method = {'POST'},
        args_len = 1,
        args = {'increment'}
    },
    incrbyfloat = {
        method = {'POST'},
        args_len = 1,
        args = {'increment'}
    },
    set = {
        method = {'POST'},
        args_len = 1,
        args = {'value'}
    },
    get = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    setbit = {
        method = {'POST'},
        args_len = 2,
        args = {'offset', 'value'}
    },
    bitop = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    bitcount = {
        method = {'GET'},
        args_len = 2,
        args = {'start', 'end'}
    },
    
    --[[sets]]     
    sadd ={
        method = {'POST'},
        args_len = 1,
        args  = {'args'}
    },
    sinter ={
        method = {'POST'},
        args_len = 1,
        args  = {'args'}
    },
    sunion ={
        method = {'POST'},
        args_len = 1,
        args  = {'args'}
    },
    scard ={
        method = {'GET'},
        args_len = 0,
        args  = {}
    },
    spop ={
        method = {'POST'},
        args_len = 0,
        args  = {}
    },
    sdiff ={
        method = {'POST'},
        args_len = 1,
        args  = {'args'}
    },
    sismember ={
        method = {'GET'},
        args_len = 1,
        args = {'member'}
    },
    srandmember ={
        method = {'GET'},
        args_len = 1,
        args  = {'count'}
    },
    smembers ={
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    srem ={
        method = {'POST'},
        args_len = 1,
        args  = {'args'}
    },
    
    --[[hash]]
    hdel = {
        method = {'POST', 'GET'},
        args_len = 1,
        args = {'args'}
    },
    hincrby = {
        method = {'POST'},
        args_len = 1,
        args = {'increment'}
    },
    hincrbyfloat = {
        method = {'POST'},
        args_len = 1,
        args = {'increment'}
    },
    hmget = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    hvals = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    hexists = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    hmset = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    hget = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    hkeys = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    hset = {
        method = {'POST'},
        args_len = 2,
        args = {'field', 'value'}
    },
    hgetall = {
        method = 
        args_len =
        args =
    },
    hlen = {
        method = {'GET'}
        args_len = 0,
        args = {}
    },
    hsetnx = {
        method = {'POST'}
        args_len = 2
        args = {'field', 'value'}
    },
    
    --[[sorted sets]]   
    zadd = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    zrem = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    zrevrangebyscore = {
        method =
        args_len =
        args =
    },
    zcard = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    zrange = {
        method = {'GET'},
        args_len = 3,
        args = {'start', 'end', 'withscores'}
    },
    zremrangebyrank = {
        method = {'POST'},
        args_len = 2,
        args = {'start', 'stop'}
    },
    zrevrank = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    zcount = {
        method = {'GET'},
        args_len = 0,
        args = {'min', 'max'}
    },
    zremrangebyscore = {
        method = {'POST'},
        args_len = 2,
        args = {'start', 'stop'}
    },
    zscore = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    zincrby = {
        method = {'POST'},
        args_len = 1,
        args = {'increment'}
    },
    zrank = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    zrevrange = {
        method = {'GET'},
        args_len = 3,
        args = {'start', 'end', 'withscores'}
    },
    
    --[[list]]    
    blpop = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    llen = {
        method = {'GET'},
        args_len = 0,
        args = {}
    },
    rpush = {
        method = {'POST'}
        args_len = 1,
        args = {'args'}
    },
    brpop = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    lpop = {
        method = {'POST'},
        args_len = 0,
        args = {}
    },
    lset = {
        method = {'POST'},
        args_len = 2,
        args = {'index', 'value'}
    },
    rpushx = {
        method = {'POST'},
        args_len = 1,
        args = {'value'}
    },
    lpush = {
        method = {'POST'},
        args_len = 1,
        args = {'args'}
    },
    ltrim = {
        method = {'POST'},
        args_len = 2,
        args = {'start', 'stop'}
    },
    lindex = {
        method = {'GET'},
        args_len = 1,
        args = {'index'}
    },
    lpushx = {
        method = {'POST'},
        args_len = 1,
        args = {}
    },
    rpop = {
        method = {'POST'},
        args_len = 0,
        args = {}
    },
    linsert = {
        method = {'POST'},
        args_len = 3,
        args = {'be_af', 'pivot', 'value'}
    },
    lrange = {
        method = {'GET'},
        args_len = 2,
        args = {'start', 'stop'}
    },
    lrem = {
        method = {'POST'},
        args_len = 2,
        args = {'count', 'value'}
    } 
}

for a, b in pairs(commands) do
    print (a)
end
