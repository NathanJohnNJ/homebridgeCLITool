import sys #importing sys to pass arguments to the script i.e. device to be controlled.
import configparser #allows to read the config.ini file in order to get the correct ID for the given device as this is needed to control it
import requests # allows to make the API request
import urllib.parse
import json
from dotenv import load_dotenv # hide sensitive information
import os #provides ways to access the Operating System and allows us to read the environment variables

load_dotenv()
#set variable to be used throughout from the dotenv file
myUser = os.getenv("USERNAME")
myPass = os.getenv("PASSWORD")
myDomain = os.getenv("DOMAIN")
myPort = os.getenv("PORT")
myPath = os.getenv("MYPATH")

# read the config.ini file to get the ID for the given device
config = configparser.ConfigParser()
config.read(f"{myPath}/config.ini")
string = config['smart'][str(sys.argv[1])]

#first get auth token
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

#Create auth header
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
#Make request and then find the section needed to read the devices state
json_data = requests.get(Url, headers=Headers).json()
dataList = json_data.values()
newList = list(dataList)[8]
endList = list(newList)
Start = 7
Stop = 8
Slice_object = slice(Start,Stop)
final = str(newList)[Slice_object]
print(final)
