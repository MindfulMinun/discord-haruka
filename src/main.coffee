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

# client.on 'guildCreate', (guild) ->
#     #! Adding a new row to the collection uses `set(key, value)`
#     Haruka.settings.set guild.id, Haruka.defaultSettings
#
# client.on 'guildDelete', (guild) ->
#     #! Removing an element uses `delete(key)`
#     Haruka.settings.delete guild.id
#
# client.on 'guildMemberAdd', (member) ->
#     #! This executes when a member joins, so let's welcome them!
#     #! Get a welcome message using `getProp`
#     message = Haruka.settings.getProp(member.guild.id, getWelcomeMessage)()
#
#     #! Send message to the welcome channel
#     member.guild.channels
#         .find "name", Haruka.settings.getProp(member.guild.id, "welcomeChannel")
#         .send welcomeMessage
#         .catch console.error

#! Catch Uncaught rejections and continue normally.
process.on 'unhandledRejection', (err) ->
    console.log "===== Uncaught Promise Rejection: =====\n", err

#! ========================================
#! Helpers
Array::choose = -> this[Math.floor(Math.random() * this.length)]
Array::last   = -> this[this.length - 1]

#! ========================================
#! Finally, log Haruka in.
client.login Haruka.config.token
