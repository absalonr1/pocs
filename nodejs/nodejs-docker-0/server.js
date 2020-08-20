//'use strict';

const express = require('express');
const http = require("http");

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

var svc_host = process.env.svc_host; 
var svc_port = process.env.svc_port;

function function2() {
  console.log('bla bla...');
}


// App
const app = express();
app.get('/', (req, res) => {
  var options = {
    host: svc_host,
    port: svc_port,
    path: '/',
    method: 'GET'
  };

  if(req.get('sleep') != null){
    console.log('waiting  '+req.get('sleep')+' millisecons...');
    setTimeout(function2, req.get('sleep'));
    
    // propago el header
    options.headers = {'sleep':req.get('sleep')}
    
  }
  else{
    console.log('not waiting...');
  }
  console.log('Llamado al backend...');
  http.request(options, function(resp) {
    //console.log('STATUS: ' + resp.statusCode);
    //console.log('HEADERS: ' + JSON.stringify(resp.headers));
    
    resp.setEncoding('utf8');
    
    resp.on('data', function (chunk) {
      //console.log('BODY: ' + chunk);
      data = JSON.parse(chunk);
      //console.log(data.mensaje);
      //console.log("header:"+req.get('sleep'));
      

      res.json({ mensajeRecontraFinal:data.mensajeFinal});
    });
  }).end();
  
});
//res.json(data);
app.listen(PORT, HOST);
console.log('Running on http://${HOST}:${PORT}');