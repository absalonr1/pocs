//'use strict';

const express = require('express');
const http = require("http");

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';


// App
const app = express();
app.get('/', (req, res) => {
  var options = {
    host: "maps.googleapis.com",
    port: 80,
    path: '/maps/api/directions/json?origin=Central%20Park&destination=Empire%20State%20Building&sensor=false&mode=walking',
    method: 'GET'
  };
  
  http.request(options, function(resp) {
    console.log('STATUS: ' + resp.statusCode);
    console.log('HEADERS: ' + JSON.stringify(resp.headers));
    resp.setEncoding('utf8');
    resp.on('data', function (chunk) {
      //console.log('BODY: ' + chunk);
      data = JSON.parse(chunk);
      console.log(data.error_message);
      res.json({ mensaje:data.error_message});
    });
  }).end();
  
});
//res.json(data);
app.listen(PORT, HOST);
console.log('Running on http://${HOST}:${PORT}');