# Python 3.4
#  'OC-API-Version: 1.0'
#       servers/{server name}/clients/{client name}/atrisk
# Script to send THJODSKAJ - ATRISK - NODEDNAME email to montoring admins

import ssl
import http.client
import json
import base64

c = http.client.HTTPSConnection("localhost", 11090, context=ssl._create_unverified_context())
credentials = base64.b64encode(b"view:iiWiphahjiezu6f").decode("ascii")

headers = {"Authorization" : "Basic " + credentials, 'Accept': 'application/json', "OC-API-Version": "1.0"}
c.request("GET", "/oc/api/clients",  headers=headers)
r = c.getresponse()

j = json.loads(r.read().decode('utf-8'))

# Dump the result to STDOUT
#print (j)

#print(type(j))

#for client in j['clients']:
#    print(client['NAME'], client['DOMAIN'])

#for client in j['clients']:
#   print("hello " + client['NAME'])

for client in j['clients']:
    if client['SERVER'] == 'TSMNEW':
       path = ("/oc/api/servers/TSMNEW/clients/" + client['NAME'] + "/atrisk")
       print (path)
       c.request("GET",path, headers=headers)
       risk = c.getresponse()
       atrisk = json.loads(risk.read().decode('utf-8'))
       print (atrisk)
