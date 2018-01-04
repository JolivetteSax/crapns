from flask import Flask, request
import json

application= Flask(__name__)
ver='0'

#TODO: crapily load the existing list from crap.json
crapfile='crap.json'


@application.route('/hosts')
def getHosts():
    #TODO crapily return the current list of hosts
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'} 

@application.route('/discover')
def checkServer():
    return "crapns v" + ver 

@application.route('/register', methods=['POST'])
def registerName():
    #TODO Crapily register the POST'd name in memory and crap.json
    print(json.dumps(request.json))
    if (request.remote_addr != request.json['ip']):
        raise Exception("remote address and registration don't match.")
    return json.dumps({'success':True}), 200, {'ContentType':'application/json'} 


if __name__ == "__main__":
    application.run(host='0.0.0.0', port=10053)
