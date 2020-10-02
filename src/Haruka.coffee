# ========================================
# The Haruka class

fs = require 'fs'
Discord = require 'discord.js'

###*
 * The options object Haruka should be instantiated with.
 * @typedef {Object} HarukaOptions
 * @property {Object} config - The configuration file.
    See `example-config.json`
 * @property {String} version - Haruka’s version.
    Defaults to `options.config.version`
 * @property {String} prefix - Haruka’s command prefix, such as `-h`.
    This must be defined.
 * @property {HarukaDefault} default - Haruka’s catch-all function.
    If Haruka detects that her prefix was sent but no function was called,
    this function can warn the sender.
###

###*
 * A catchall function, called when a message starts with Haruka's prefix,
 * but no function matched its regular expression.
 * @callback HarukaDefault
 * @param {Message} msg - A DiscordJS Discord message.
###

###*
 * Describes a Haruka function. These functions are passed to
 * the Haruka instance via Haruka::add()
 * @typedef {Object} HarukaFn
 * @property {String} name - The function name.
 * @property {HarukaHandler} handler - The Haruka message handler
 * @property {RegExp} [regex] - The regular expression that should trigger
 * this function. If this function is a special function, omit this property.
 * @property {Object} help - This function's help descriptions.
 * @property {String} [help.short] - This function's short help description.
 * Can be omitted if help.hidden is set to true.
 * @property {String} help.long - This function's long help description.
 * @property {Boolean} [help.hidden=true] - Whether this function should show up
 * in the generic help list. Defaults to true.
###

###*
 * A Haruka message handler.
 * @callback HarukaHandler
 * @param {Message} msg - A DiscordJS Discord message
 * @param {Array} [match] - The RegExp match that triggered this message.
    This argument is omitted if this function is a Special function.
 * @param {Haruka} H - The Haruka instance this function is attached to.
###

###*
 * The Haruka class.
 * @author MindfulMinun
 * @param {HarukaOptions} options - Haruka’s options.
 * @since 2.0.0
 * @version 2.0.0
###
class Haruka
    constructor: (options) ->
        # Set a couple variables for later
        @client = new Discord.Client
        @config = options.config ? {}
        @version = options.version ? @config.version
        @default = options.default
        ###*
         * Haruka's function prefix, such as `-h`.
         * It musn't contain any whitespace.
         * @type {String}
        ###
        @prefix = options.prefix ? @config.prefix ?
            throw Error "Haruka requires a command prefix."
        if /\s/.test @prefix
            throw Error "Haruka’s prefix should not contain any whitespace."

        ###*
         * A collection of functions, meant to be added via
         * `Haruka::add('function', fn)`
         * @type {Array<HarukaFn>}
        ###
        @functions = []
        ###*
         * A collection of special functions, meant to be
         * added via `Haruka::add('special', fn)`
         * @type {Array<HarukaFn>}
        ###
        @specials  = []

    ###*
     * Haruka will attempt to reply to the given Discord message
     * if it starts with the prefix. If it can't find one,
     * it will call the `default` function passed during instantiation.
     * @author MindfulMinun
     * @param {Message} msg - The discord.js Discord message
     * @returns {*} The return value of the handler function or
        `undefined` if the message was sent by a bot or doesn't
        start with the prefix.
     * @since 0.1.0
     * @version 2.0.0
    ###
    try: (msg) ->
        # ========================================
        # Run Specials first
        for fn in @specials
            # Break if handler returns a truthy value.
            if temp = fn.handler(msg, @) then return temp

        # ========================================
        # Functions

        # Check if the message starts with the prefix,
        # and it's not from another bot.
        if (not msg.content.startsWith @prefix) or msg.author.bot then return

        commands = msg.content.replace(@prefix, '').trim()

        # Run through all the commands and see if one matches.
        for fn in @functions
            regexMatch = fn.regex.exec commands
            if regexMatch
                # 2020-10-01 18:40:13
                # OK so i'm planning to kill Haruka, but before I do that
                # I wanna gauge how many people actually use her (besides me)
                # When a function is successful, Haruka sends a message
                # in a secret channel in a secret server with stats about the message
                if process.env.HARUKA_LOG_GUILD_ID
                    embed = new Discord.RichEmbed()
                        .setColor '#448aff'
                        .setURL "https://discordapp.com/channels/#{msg.guild.id}/#{msg.channel.id}/#{msg.id}"
                        .setTitle fn.name
                        .setDescription  msg.content
                        .addField 'Sender', msg.author.tag
                        .addField 'Guild', msg.guild?.name or '???'
                        .addField 'Channel', '#' + (msg.channel?.name or '???')
                        .setFooter msg.createdAt.simple()
                        .setTimestamp msg.createdAt
                
                    @client.guilds.get(process.env.HARUKA_LOG_GUILD_ID)
                        ?.channels.get(process.env.HARUKA_LOG_CHANNEL_ID)
                        ?.send(embed)
                
                return fn.handler(msg, regexMatch, @)

        # Catchall
        return @default(msg)

    ###*
     * Adds a function to Haruka. This function will be called if a
     * message's content matches its RegExp
     * @author MindfulMinun
     * @param {String} type - An enumerated string, either
        "function" or "special"
     * @param {HarukaFn} fn - A Haruka message handler function.
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
