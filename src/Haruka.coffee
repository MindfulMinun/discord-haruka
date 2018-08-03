#! ========================================
#! Creating Haruka

###
 * The message handlers will be passed a snapshot of the Haruka object.
 * The Haruka object has the following structure:

    Haruka {
        dev: Boolean
        version: String<SemVer>
        functions: [{
            name: String
            regex: RegExp
            handler: Function
            help: Object
        }, ...]
        specials: [{
            name: String
            handler: Function
        }, ...]
        prefix: Enum('-h', '#h')
        addFunction: Function
        try: Function
        config: JSON
    }
###

Haruka = {}
#! Dev, Version, and Prefix have moved to main.coffee,
#! and are determined from config.json
Haruka.functions = []
Haruka.specials  = []

#! ========================================
#! Modules
fs = require 'fs'

#! ========================================
#! Take Haruka's functions and add them to the queue
fs.readdirSync "#{__dirname}/functions"
    .filter (filename) ->
        /^(?:[^_]).+(?:\.(?:coffee|js))/.test filename
    .forEach (filename) ->
        Haruka.functions.push(
            require "#{__dirname}/functions/#{filename}"
        )

#! ========================================
#! Likewise, take Haruka's special functions and add them to the other queue
fs.readdirSync "#{__dirname}/specials"
    .filter (filename) ->
        /^(?:[^_]).+(?:\.(?:coffee|js))/.test filename
    .forEach (filename) ->
        Haruka.specials.push(
            require "#{__dirname}/specials/#{filename}"
        )

Haruka.try = (msg) ->
    #! ========================================
    #! Run Specials first
    for fn in Haruka.specials
        #! Break if handler returns a truthy value.
        if fn.handler(msg, Haruka) then return

    #! ========================================
    #! Functions

    #! Tokenize input
    txt = msg.content.tokenize()
    txt[1] = if txt[1] then txt[1] else "help"

    #! Check if the message starts with the prefix,
    #! and it's not from another bot.
    if (txt[0] isnt Haruka.prefix) or msg.author.bot then return

    #! Run through all the commands and see if one matches.
    for fn in Haruka.functions
        regexMatch = fn.regex.exec txt[1]
        if regexMatch
            return fn.handler(msg, regexMatch, Haruka)

    #! Catchall
    return msg.reply [
        "Hmm, I'm not sure what you mean by that."
        "Sorry, I don't know what you meant by that."
        "I’m not sure I understand."
        "I’m not sure what you mean."
    ].choose() + " Try `-h help` for a list of commands."

module.exports = Haruka
