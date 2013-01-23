redis-restful
=============

redis的restful实现

+ 使用restful接口访问和调用redis 
+ 便于控制redis访问
+ 规范化对redis统一操作
+ 增强都redis的可控制性


###uri

 应用名称  类型       命令
    |       |         |
/{appid}/{types}/.../{cmd}


###config format

    commands = {
        cmd0 = {
            {
                method = '',
                args_len = '',
                args = {
                    { 
                        name = 
                        separate = 
                    }
                    ...
                }
            }
            ...
        }
        cmd1 = {
    
        }
        ...
    }


