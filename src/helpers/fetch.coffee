###
 * Async request
###
request = require 'request'

module.exports = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            if (not err) and (200 <= response?.statusCode < 400)
                resolve JSON.parse body
            else
                reject response
