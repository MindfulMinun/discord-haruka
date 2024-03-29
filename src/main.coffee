# Require
fs     = require 'fs'
config = require '../config.json'
Haruka = require './Haruka'

do ->
    require('dotenv').config()
    p = require '../package.json'
    config.version = "v#{p.version or "?.?.?"}"
    config.name = p.name
    config.dev = not /production/i.test(process.env.NODE_ENV or '')
    config.ops = (process.env.HARUKA_OPS or '').split(',')

# Start
haruka = new Haruka({
    prefix: if config.dev then '#h' else '-h'
    config: config
    default: (msg) ->
        # console.log msg.content
        # c = msg.content.replace(@prefix, '').trim()
        # console.log c
        # if c is ''
        #     # Call the Help function if no arguments provided.
        #     help = @functions.find((f) -> f.name is 'Help')
        #     help.handler(msg, null, @)
        # else
        msg.reply [
            "Hmm, I'm not sure what you mean by that."
            "Sorry, I don't know what you meant by that."
            "I’m not sure I understand."
            "I’m not sure what you mean."
        ].choose() + " Try `-h help` for a list of commands."
})

# ========================================
# Add event listeners
haruka.client.on 'ready', ->
    d = new Date
    haruka.client.user.setActivity 'Hentai | -h help', type: 'WATCHING'

    if config.dev
        console.log """
            Started Haruka in DEVELOPMENT mode.
            Logged in as #{haruka.client.user.tag} on #{d.toUTCString()}.
        """
    else
        console.log """
            Logged in as #{haruka.client.user.tag} on #{d.toUTCString()}.
        """
haruka.client.on 'message', (msg) ->
    try
        haruka.try msg
    catch err
        #! I hope this catches bugs
        r = new RegExp(process.cwd(), 'gi')
        msg.channel.send """
            **An exception has occurred:** This is a bug, this shouldn’t happen.
            Create a GitHub issue or contact me via Discord (MindfulMinun#3386).
            Information regarding the exception is provided below.
            (I hope Monika has nothing to do with this.)
            ```\n#{err.stack.replace(r, '~')}\n```
        """
        console.warn "\n===== Uncaught Fatal Error: =====\n", err

# ========================================
# Add functions

# Take Haruka's functions and add them to the queue
fs.readdirSync "#{__dirname}/functions"
    .filter (filename) ->
        /^(?:[^_]).+(?:\.(?:coffee|js))/.test filename
    .forEach (filename) ->
        haruka.add('function', require "#{__dirname}/functions/#{filename}")

# Likewise, take Haruka's special functions and add them to the other queue
fs.readdirSync "#{__dirname}/specials"
    .filter (filename) ->
        /^(?:[^_]).+(?:\.(?:coffee|js))/.test filename
    .forEach (filename) ->
        haruka.add('special', require "#{__dirname}/specials/#{filename}")

#! Catch uncaught rejections and continue normally.
process.on 'unhandledRejection', (err) ->
    console.log "===== Uncaught Promise Rejection: =====\n", err

#! ========================================
#! Helpers
do ->
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
    String::capitalize = ->
        #! Capitalize the first letter of this string.
        this.charAt(0).toUpperCase() + this.slice(1)

#! ========================================
#! Finally, log Haruka in.
haruka.client.login process.env.DISCORD_TOKEN

console.log(haruka)
