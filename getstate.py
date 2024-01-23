import sys
import configparser
import requests
import urllib.parse
import json
from dotenv import load_dotenv
import os #provides ways to access the Operating System and allows us to read the environment variables

load_dotenv()

myUser = os.getenv("USERNAME")
myPass = os.getenv("PASSWORD")
myDomain = os.getenv("DOMAIN")
myPort = os.getenv("PORT")

config = configparser.ConfigParser()
config.read('/home/pi/scripts/homebridgeCLITool/config.ini')
string = config['smart'][str(sys.argv[1])]
headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
}
data = f'{{"username":"{myUser}", "password":"{myPass}"}}'
response = requests.post(f"https://{myDomain}:{myPort}/api/auth/login", headers=headers, data=data)
start = 17
stop = 329
slice_object = slice(start,stop)
result = str(response.text)[slice_object]

Bear = 'Bearer '
Auth = ''.join([Bear, result])
Headers = {
    'accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization': Auth,
}
url = f"https://{myDomain}:{myPort}/api/accessories/"
device = str(string)
Url = ''.join([url, device])
json_data = requests.get(Url, headers=Headers).json()
dataList = json_data.values()
newList = list(dataList)[8]
endList = list(newList)
Start = 7
Stop = 8
Slice_object = slice(Start,Stop)
final = str(newList)[Slice_object]
print(final)
