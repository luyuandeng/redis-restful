#-*-coding: utf-8 -*-
# sudo pip install requests
import  requests
import json
import random
import md5


apps = {'appid', 'default'}
types = {'key', 'keys'}

if __name__ == "__main__":
    form = {'value':'www.google.com'}
    r = requests.post('http://localhost:8080/default/key/google/set', data = form)
    print r.text

