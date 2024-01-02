import sys #importing sys to pass arguments to the script i.e. device to be controlled.
import configparser #allows to read the config.ini file in order to get the correct ID for the given device as this is needed to control it
import requests # allows to make the API request
from dotenv import load_dotenv # hide sensitive information
import os #provides ways to access the Operating System and allows us to read the environment variables

#initialise dotenv and assign the data within the .env file to variables
load_dotenv()
myUser = os.getenv("USERNAME")
myPass = os.getenv("PASSWORD")
myDomain = os.getenv("DOMAIN")
myPort = os.getenv("PORT")

# read the config.ini file to get the ID for the given device
config = configparser.ConfigParser()
config.read('/home/pi/scripts/homebridgeCLITool/config.ini')
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
#contorl the device with put request
Data = '{"characteristicType": "On", "value": "1"}'
url = f"https://{myDomain}:{myPort}/api/accessories/"
light = str(string)
Url = ''.join([url, light])
mon = requests.put(Url, headers=Headers, data=Data)
