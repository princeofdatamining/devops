# -*- coding: utf-8 -*-
""" http://liftoff.github.io/GateOne/Developer/embedding_api_auth.html#python
api_key, secret = "MjkwYzc3MDI2MjhhNGZkNDg1MjJkODgyYjBmN2MyMTM4M", "secret"
authobj = {
    'api_key': api_key,
    'upn': "joe@company.com",
    'timestamp': str(int(time.time() * 1000)),
    'signature_method': 'HMAC-SHA1',
    'api_version': '1.0'
}
authobj['signature'] = create_signature(authobj['api_key'], authobj['upn'], authobj['timestamp'])
valid_json_auth_object = json.dumps(authobj)
"""
import time
import hashlib
import hmac
import json
from django.utils.encoding import force_bytes


DEFAULT_API_VERSION = '1.0'
DEFAULT_SIGNATURE_METHOD = 'HMAC-SHA1'
DEFAULT_DIGESTMOD = hashlib.sha1
SIGNATURE_DIGESTMODS = {
    DEFAULT_SIGNATURE_METHOD: DEFAULT_DIGESTMOD,
}


def create_signature(secret, *parts, **kwargs):
    hash = hmac.new(force_bytes(secret), digestmod=hashlib.sha1)
    for part in parts:
        hash.update(force_bytes(part))
    return hash.hexdigest()


def create_auth_object(api_key, secret, upn, **kwargs):
    timestamp = str(int(time.time() * 1000))
    method = kwargs.get('signature_method') or DEFAULT_SIGNATURE_METHOD
    digestmod = SIGNATURE_DIGESTMODS[method]
    signature = create_signature(secret, api_key, upn, timestamp,
                                 digestmod=digestmod)
    return {
        'api_key': api_key,
        'upn': upn,
        'timestamp': timestamp,
        'signature_method': method,
        'api_version': kwargs.get('api_version') or DEFAULT_API_VERSION,
        'signature': signature,
    }


def _main():
    import sys
    import os
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('api_key')
    parser.add_argument('secret')
    parser.add_argument('upn')
    args = parser.parse_args()
    authobj = create_auth_object(args.api_key, args.secret, args.upn)
    print(json.dumps(authobj, indent=2))

if __name__ == "__main__":
    _main()
