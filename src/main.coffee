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
            Logged in as #{client.user.tag} on #{d.toUTCString()}.
        """
    else
        console.log """
            Logged in as #{client.user.tag} on #{d.toUTCString()}.
        """
client.on 'message', (msg) -> Haruka.try msg

client.on 'guildCreate', (guild) ->
    #! Adding a new row to the collection uses `insert(key, value)`
    Haruka.db.serverSettings.insert(guild.id, Haruka.defaultSettings)

client.on 'guildDelete', (guild) ->
    #! Removing an element uses `delete(key, options, cb)`
    Haruka.db.serverSettings.remove({ _id: guild.id }, {}, (->))

client.on 'guildMemberAdd', (member) ->
    #! This executes when a member joins, so let's welcome them!
    #! Check if Haruka should welcome members using `db.find`
    db.find({ _id: member.guild.id }, (err, docs) ->
        if err then return

        if docs.shouldWelcomeNewMembers is yes
            #! Send message to channel
            member.guild.channels
                .find "name", docs.welcomeChannel
                .send [
                    "Welcome to the server, #{member}!"
                    # "サーバへようこそ, #{member}さま！"
                    "Behold! #{member} has arrived!"
                    "A wild #{member} appeared!"
                    "The man, the myth, the legend, #{member} has arrived!"
                    "#{member} joined the party."
                ].choose()
                .catch console.error

    )

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
