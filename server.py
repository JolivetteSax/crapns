from flask import Flask, request
import json

application= Flask(__name__)
ver='0'

#TODO: crapily load the existing list from crap.json
crapfile='crap.json'
hosts={}

@application.route('/hosts')
def getHosts():
    return json.dumps(hosts), 200, {'ContentType':'application/json'} 

@application.route('/discover')
def checkServer():
    return "crapns v" + ver 

@application.route('/register', methods=['POST'])
def registerName():
    print(json.dumps(request.json))
    if (request.remote_addr != request.json['ip']):
        raise Exception("remote address and registration don't match.")
    hosts[request.json['name']] = request.json['ip']
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'} 


if __name__ == "__main__":
    application.run(host='0.0.0.0', port=10053)
