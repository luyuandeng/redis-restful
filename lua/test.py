#-*-coding: utf-8 -*-
# sudo pip install requests
import  requests
import json
import random
import md5


r = requests.get('http://localhost:8080/default/key/dfdsr/member/fdssde/del')
print r.text

apps = {'appid', 'default'}
types = {'key', 'keys'}

