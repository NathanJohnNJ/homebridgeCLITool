#!/usr/local/bin/node

// import dotenv for hiding sensitive information, import prompt for user input later in the script
require('dotenv').config()
const prompt = require("prompt-sync")();
// Create an exclusions list of devices I don't want include. Also in this list are the devices that are made for each plug-in, so not actual devices to be controlled.
const exclusions = ['Bedroom Motion Sensor 2F6E', 'TuyaPlatform 0BA5', 'TuyaWebPlatform 2CFF', 'TuyaIR 8B72', 'Homebridge 57E5 05BE', 'Contact Sensor', 'MotionSensor', 'WindowCovering'];

// First get authorization token for the next request
const getToken = async () => {
    // console.log('Hi from getToken()')
const myDomain = process.env.DOMAIN
const myPort = process.env.PORT
    const url = `https://${myDomain}:${myPort}/api/auth/login`
    const data = '{"username":process.env.USERNAME, "password":process.env.PASSWORD, "otp": "string"}'
    const headers = {
        'accept': '* / *',
        'Content-Type': 'application/json'
    }
    const response = await fetch(url, {
        method: 'POST',
        headers: headers,
        body: data
    })
    if (!response.ok) {
        throw new Error(response.statusText)
        }
    const responseData = await response.json()
    const token = responseData.access_token
    // console.log(token)
    return token
  }

// Next get the name and unique ID for each device linked to homebridge
const fetchData = async () => {
    const token = await getToken();
    try {
    const url = `https://${myDomain}:${myPort}/api/accessories`
    const response = await fetch(url, {
        headers:{"accept" : "* / *",
        "Authorization": "Bearer " + token
        }
    })
    if (!response.ok) {
        throw new Error(response.statusText)
        }
    const data = await response.json()
    // console.log(data)
// by declaring a new array here and then using the map function to push to it instead of using the array the map
//function will create itself allows me to exclude any devices I don't wish to control, so therefore don't need in my config.ini file
    let homeData = [];
    data.map((accessory, i) => {
        if(exclusions.includes(accessory.humanType)){
            console.log('Excluding ' + accessory.serviceName)
       }else if(exclusions.includes(accessory.type)){
             console.log('Excluding ' + accessory.serviceName)
        }else if(exclusions.includes(accessory.serviceName)){
            console.log('Excluding ' + accessory.serviceName)
        } else{
            homeData.push({
                name: accessory.serviceName,
                uniqueId: accessory.uniqueId
              })
        }
    })
    return(homeData)
    } catch (err) {
      console.log(err)
    }
}
// function to allow me to assign a name thats quicker to type and easier to remember than the given name from homebridge
function getName(accessory){
    const userInput = prompt('What do you want to call ' + accessory.name + '?  ')
    return userInput
}

// Map through the array of data and first ask if I would like to include it in the resulting config.ini file, if so ask me what I want to call it
// Again I've declared a new array at the start of this function to allow for further exclusions
const processData = async () =>{
    const data = await fetchData()
    let newArray= [];
    data.map((accessory) => {
        const include = prompt('Do you want to include ' + accessory.name + '? (Y/n)  ')
        if (include=='Y'){
            const userInput = getName(accessory)
            newArray.push( {
                name: userInput,
                uniqueId: accessory.uniqueId
            })
        } else if (include=='y'){
            const userInput = getName(accessory)
            newArray.push( {
                name: userInput,
                uniqueId: accessory.uniqueId
            })
        } else if (include=='yes'){
            const userInput = getName(accessory)
            newArray.push( {
                name: userInput,
                uniqueId: accessory.uniqueId
            })
        } else {
            console.log('Not including ' + accessory.name + '.')
        }
    })
// finally create an array with the name and unique ID in the correct format to be used in a config.ini file
    let lastArray = []
    newArray.map((accessory) => {
        const outPut = `${accessory.name} = ${accessory.uniqueId}`
        lastArray.push(outPut)
    })
    return lastArray
}

// import the fs module to be able to read and write to the local filesystem
const fs = require('fs');

//final function that will actually be the only function called, sparking a chain reaction through the others.
//This function will commit the formatted strings from above to the local config.tmp file.
// If the file doesn't exist it will create it
const makeConfig = async() => {
    const finalData = await processData()
    const content =  `
    [smart]
    ${finalData}
    `
    fs.writeFile(
        'config.tmp',
        content,
        (error) => {
          if (error) {
            console.log(error);
          }
          console.log('File written successfully');
        }
      );
}
//call the function to spark the chain reaction through all functions
makeConfig()
