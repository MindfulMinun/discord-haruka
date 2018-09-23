#! ========================================
#! The Haruka class

fs = require 'fs'
Discord = require 'discord.js'

###*
 * The Haruka class.
 * @author MindfulMinun
 * @param {Object} options - Haruka’s options.
 * @param {Object} options.config - The configuration file.
    See `example-config.json`
 * @param {Object} options.version - Haruka’s version.
    Defaults to `options.config.version`
 * @param {Object} options.prefix - Haruka’s command prefix, such as `-h`.
    This must be defined.
 * @since 2.0.0
 * @version 2.0.0
###
class Haruka
    constructor: (options) ->
        # Set a couple variables for later
        @client  = new Discord.Client
        @config  = options.config ? {}
        @version = options.version ? @config.version
        @prefix  = options.prefix ? @config.prefix ?
            throw Error "Haruka requires a command prefix."

        ###*
         * A collection of functions, meant to be added via
         * `Haruka::add('function', fn)`
        ###
        @functions = []
        ###*
         * A collection of special functions, meant to be
         * added via `Haruka::add('special', fn)`
        ###
        @specials  = []

    ###*
     * Haruka will attempt to reply to the given Discord message.
     * @author MindfulMinun
     * @param {Message} msg - The discord.js Discord message
     * @returns {*} The return value of the handler function
        or `undefined` if none was called.
     * @since 0.1.0
     * @version 2.0.0
    ###
    try: (msg) ->
        #! ========================================
        #! Run Specials first
        for fn in @specials
            #! Break if handler returns a truthy value.
            if temp = fn.handler(msg, @) then return temp

        #! ========================================
        #! Functions

        #! Tokenize input
        txt = msg.content.tokenize()
        txt[1] = if txt[1] then txt[1] else "help"

        #! Check if the message starts with the prefix,
        #! and it's not from another bot.
        if (txt[0] isnt @prefix) or msg.author.bot then return

        #! Run through all the commands and see if one matches.
        for fn in @functions
            regexMatch = fn.regex.exec txt[1]
            if regexMatch
                return fn.handler(msg, regexMatch, @)

        #! Catchall
        msg.reply [
            "Hmm, I'm not sure what you mean by that."
            "Sorry, I don't know what you meant by that."
            "I’m not sure I understand."
            "I’m not sure what you mean."
        ].choose() + " Try `-h help` for a list of commands."

    ###*
     * Adds a function to Haruka’s queue
     * @author MindfulMinun
     * @param {String} type - An enumerated string, either
        "function" or "special"
     * @returns {Haruka} The Haruka object with the function added to it.
     * @since Sep 23, 2018 - 2.0.0
     * @version 2.0.0
    ###
    add: (type, fn) ->
        switch type
            when "function" then @functions.push fn
            when "special"  then @specials.push fn
            else throw Error "Expected type to be either
                “function” or “special”, was instead “#{type}”"
        @

module.exports = Haruka
