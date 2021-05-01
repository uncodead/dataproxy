from flask import Flask, request

from app import *

application = Flask(__name__)

if __name__ == "__main__":
    application.run()


@application.route('/')
def hello_world():
    url = request.args.get("url")
    flow = _get_flow_parameters()
    proxy = JsonpDataProxy(3000000)
    proxy.proxy_query(flow, url, flow.query)
    resp = ''.join([x.encode('utf-8') for x in flow.http_response.body])
    callback = request.args.get("callback")
    return str(callback + '(' + resp + ')')


def _get_flow_parameters():
    flow = AttributeDict()
    flow['app'] = AttributeDict()
    flow['app']['config'] = AttributeDict()
    flow['app']['config']['proxy'] = AttributeDict(max_length=int(100000))
    flow['environ'] = request.args
    flow['http_response'] = HTTPResponseMarble()
    flow['query'] = FieldStorage(environ=flow.environ)
    return flow
