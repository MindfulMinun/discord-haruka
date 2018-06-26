#! ========================================
#! Haruka Setup
fs      = require 'fs'
Discord = require 'discord.js'
config  = require '../config.json'
Haruka  = require './Haruka.js'

client = new Discord.Client
Haruka.config = config

#! ========================================
#! Add event listeners
client.on 'ready', ->
    d = new Date
    client.user.setActivity 'Try -h help'
    if Haruka.dev
        console.log """
            Started Haruka in DEVELOPMENT mode.
            Logged in as #{client.user.tag} on #{d.toUTCString()}.\n
        """
    else
        console.log """
            Logged in as #{client.user.tag} on #{d.toUTCString()}.\n
        """
client.on 'message', (msg) -> Haruka.try msg

#! Catch Uncaught rejections and continue normally.
process.on 'unhandledRejection', (err) ->
    console.log "===== Uncaught Promise Rejection: =====\n", err

#! ========================================
#! Helpers
Array::choose = ->
    #! Choose a random element from this array.
    this[Math.floor(Math.random() * this.length)]

Array::last = ->
    #! Retrieve this array's last element.
    this[this.length - 1]

String::tokenize = ->
    #! Split this string at the first occurrence of whitespace.
    this.replace(/\s+/, '\x01').split '\x01'

#! ========================================
#! Finally, log Haruka in.
client.login Haruka.config.token
