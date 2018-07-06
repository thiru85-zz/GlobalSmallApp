/*
Copyright 2016 Google Inc. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

'use strict';
//requirements & dependencies
var express = require('express');
var fs = require('fs');
var util = require('util');
var mime = require('mime');
var multer = require('multer');
var upload = multer({dest: 'uploads/'});
var os = require('os');

// Set up auth
var vision = require('@google-cloud/vision');

// 
var hostname = os.hostname();

var vision1 = new vision.ImageAnnotatorClient({
    keyFilename:'key.json',
    projectId: 'gcpdemoproject'
}); //auth to project

var app = express();

var request = require('request'); //init request module for querying Metadata from GCE
var opts = { //setting options for pulling metadata
    url : 'http://metadata.google.internal/computeMetadata/v1/instance/hostname', //metadata URL
    headers: {
        'Metadata-Flavor':'Google'
    }
};


 

// Simple upload form
var form = '<!DOCTYPE HTML><html>' +
  "<body>" +
  "<head>" +
  "<style> h1 {color: green, border-color: coral, border-style: solid;} h3 {color: blue, font-weight: bold;}" +
  "</style></head>" +
  "<p>" +
  "<p>" +
  "<h1>This is a sample App to send an image to the Vision API and return a response</h1>" +
  "<form method='post' action='/upload' enctype='multipart/form-data'>" +
  "<input type='file' name='image'/>" +
  "<input type='submit' /></form>" +
  "<p>" +
  "<p>" +
  "<h1>This was rendered by the pod: " + hostname + "</h1>" +
  "<p>" +
  "<p>" +
  '<h3> And running on the GKE Node: ';

var pageEnd = '</h3></body></html>';

app.get('/', function(req, res) {
  res.writeHead(200, {
    'Content-Type': 'text/html'
  });
  request(opts, function(err, resp, body){
      res.write(form);
      res.write(body);
      res.end(pageEnd);
  });
});

// Get the uploaded image

// Image is uploaded to req.file.path
app.post('/upload', upload.single('image'), function(req, res, next) {
  // Vision API performs web detection and writes in a table
  // Send the image to the Cloud Vision API
  var request = {
      image: {
          source: {
              filename:req.file.path
          }
        }
  }
  vision1.webDetection(request, function(err, detections) { //messy to convert the response into table format
    if (err) {
      res.end('Cloud Vision Error');
    } else {
      res.writeHead(200, {
        'Content-Type': 'text/html'
      });
      res.write('<img width=300 src="' + base64Image(req.file.path) + '"><br>');

      var output = '<html><head></head><body><h1>API Output</h1><ul><table border=1><tr>';
      output += '<th>EntityID</th>';
      for (var index in detections.webDetection.webEntities) {
        output += '<td>' + JSON.stringify(detections.webDetection.webEntities[index].entityId) + '</td>';
      }
      output += '</tr>';
      output += '<tr>';
      output += '<th>Score</th>';
      for (var index in detections.webDetection.webEntities) {
        output += '<td>' + JSON.stringify(detections.webDetection.webEntities[index].score) + '</td>';
      }
      output += '</tr>';
      output += '<tr>';
      output += '<th>Description</th>';
      for (var index in detections.webDetection.webEntities) {
        output += '<td>' + JSON.stringify(detections.webDetection.webEntities[index].description) + '</td>';
      }
      output += '</td>';
      output += '</ul></body></html>';
      // Write out the tabularized output of the Vision API
      res.end(output);
      console.log(detections);
      // Delete file (optional)
      fs.unlinkSync(req.file.path);

    }
  });
});

app.listen(8080);
console.log('Server Started on port 8080');

// Turn image into Base64 so we can display it easily
function base64Image(src) {
  var data = fs.readFileSync(src).toString('base64');
  return util.format('data:%s;base64,%s', mime.getType(src), data);
}