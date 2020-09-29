'use strict';

const { Client } = require('hazelcast-client');
const express = require('express');

const PORT = process.env.PORT;
const HOST = process.env.HOST;
const HZ_SVC = process.env.HZ_SVC
var clienthz;

async function createConnection() {
    try {
        
        clienthz = await Client.newHazelcastClient({
            clusterName: 'dev',
            network: {
                clusterMembers: [
                    HZ_SVC //'127.0.0.1:5701'
                ]
            },
            lifecycleListeners: [
                (state) => {
                    console.log('Lifecycle Event >>> ' + state);
                }
            ]
          });
    } catch (err) {
        console.error('Error occurred:', err);
    }
}

var prom = createConnection();

// App
const app = express();




app.get('/', (req, res) => {
    (async () => {
        try {
            if(clienthz != undefined){
                const map = await clienthz.getMap('customers-1601318546733');
    
                const value = await map.get('1');
                console.log('Plain value:', value);    
                //await clienthz.shutdown();
                res.send({ valueFromCache: value });
            }else{
                res.send(res.send({ status: 'initializing' }));
            }
            
            
        } catch (err) {
            console.error('Error occurred:', err);
        }
    })();
});

console.log("");
console.log("#######################################");
console.log(`## Running on http://${HOST}:${PORT} ##`);
console.log("#######################################");
console.log("");
app.listen(PORT, HOST);
