// Generated by CoffeeScript 2.3.1
/*
 * Async request
 */
var request;

request = require('request');

module.exports = function(options) {
  return new Promise(function(resolve, reject) {
    return request(options, function(err, response, body) {
      var ref;
      if ((!err) && ((200 <= (ref = response != null ? response.statusCode : void 0) && ref < 400))) {
        return resolve(JSON.parse(body));
      } else {
        return reject(response);
      }
    });
  });
};