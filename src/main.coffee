#! ========================================
#! Haruka Setup
fs      = require 'fs'
Discord = require 'discord.js'
config  = require '../config.json'
Haruka  = require './Haruka'

client = new Discord.Client
Haruka.config = config
Haruka.version = config.version
Haruka.dev = config.dev
Haruka.prefix = if Haruka.dev then '#h' else '-h'
Haruka.client = client

#! ========================================
#! Add event listeners
client.on 'ready', ->
    d = new Date
    client.user.setActivity 'Hentai | -h help', type: 'WATCHING'

    if Haruka.dev
        console.log """
            Started Haruka in DEVELOPMENT mode.
            Logged in as #{client.user.tag} on #{d.toUTCString()}.
        """
    else
        console.log """
            Logged in as #{client.user.tag} on #{d.toUTCString()}.
        """
client.on 'message', (msg) ->
    try
        Haruka.try msg
    catch err
        #! I hope this catches bugs
        r = new RegExp(process.cwd(), 'gi')
        msg.channel.send """
            **An exception has occurred:** This is a bug, this shouldn’t happen.
            Create a GitHub issue or contact me via Discord (MindfulMinun#3386).
            Information regarding the exception is provided below.
            ```\n#{err.stack.replace(r, '~')}\n```
        """
        console.warn "\n===== Uncaught Fatal Error: =====\n", err

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

Array::first = ->
    #! Retrieve this array’s first element (for chained calls)
    this[0]

String::tokenize = ->
    #! Split this string at the first occurrence of whitespace.
    this.replace(/\s+/, '\x01').split '\x01'

#! ========================================
#! Finally, log Haruka in.
client.login Haruka.config.token
