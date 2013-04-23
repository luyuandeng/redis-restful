redis-restful
=============

###redis的restful实现

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

TODO
====

+ check config file
+ append test case
+ make diffrent appid to diffrent instance
+ add check head module
+ auth action
+ ...

###Usage

    mkdir mywork
    git clone git@github.com:cloudaice/redis-restful.git

修改`openresty.server`里面配置路径

  + DAEMON: 设置nginx可执行文件路径
  + CONF: 设置nginx配置文件路径
  + PID: 设置nginx进程的pid文件路径
  + ROOTPATH: 设置当前工作环境的路径，作为根路径
