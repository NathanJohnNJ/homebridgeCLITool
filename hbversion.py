import requests
from dotenv import load_dotenv
import os #provides ways to access the Operating System and allows us to read the environment variables

load_dotenv()

myUser = os.getenv("USERNAME")
myPass = os.getenv("PASSWORD")
myDomain = os.getenv("DOMAIN")
myPort = os.getenv("PORT")

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
Url = f"https://{myDomain}:{myPort}/api/status/homebridge-version"
Response = requests.get(Url, headers=Headers)
body = Response.json()
state = body["updateAvailable"]
if state == "True":
    end = 0;
else:
    end = 1;
print(end);
