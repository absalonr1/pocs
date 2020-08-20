//'use strict';

const express = require('express');
const http = require("http");

// Constants
const PORT = 8082;
const HOST = '0.0.0.0';

function function2() {
  console.log('bla bla...');
}
// App
const app = express();
app.get('/', (req, res) => {

  if(req.get('sleep') != null){
    console.log('waiting  '+req.get('sleep')+' millisecons...');
    setTimeout(function2, req.get('sleep'));
  }
  else{
    console.log('not waiting...');
  }

  var options = {
    host: "maps.googleapis.com",
    port: 80,
    path: '/maps/api/directions/json?origin=Central%20Park&destination=Empire%20State%20Building&sensor=false&mode=walking',
    method: 'GET'
  };
  
  http.request(options, function(resp) {
    //console.log('STATUS: ' + resp.statusCode);
    //console.log('HEADERS: ' + JSON.stringify(resp.headers));
    resp.setEncoding('utf8');
    resp.on('data', function (chunk) {
      //console.log('BODY: ' + chunk);
      data = JSON.parse(chunk);
      //console.log(data.error_message);
      res.json({ mensaje:data.error_message});
    });
  }).end();
  
});
//res.json(data);
app.listen(PORT, HOST);
console.log('Running on http://${HOST}:${PORT}');