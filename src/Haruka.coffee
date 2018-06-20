#! ========================================
#! Creating Haruka
Haruka = {}
Haruka.dev = yes
Haruka.functions = []
Haruka.prefix = if Haruka.dev then '#h' else '-h'

#! ========================================
#! Modules
fs          = require 'fs'
Enmap       = require 'enmap'
EnmapSQLite = require 'enmap-sqlite'

#! ========================================
#! Enmap
# provider = new EnmapSQLite({ name: 'settings' })
# Haruka.settings = new Enmap({
#     provider: new EnmapSQLite({
#         name: 'settings'
#     })
# })

Haruka.defaultSettings = {
    modRole: "Moderator"
    adminRole: "Admin"
    welcomeChannel: "welcome"
    getWelcomeMessage: (member) ->
        [
            "Welcome to the server, #{member}!"
            # "サーバへようこそ, #{member}さま！"
            "Behold! #{member} has arrived!"
            "A wild #{member} appeared!"
            "The man, the myth, the legend, #{member}!"
            "#{member} joined the party."
        ].choose()
}

#! ========================================
#! Helper functions
Array::choose = -> this[Math.floor(Math.random() * this.length)]

Haruka.addFunction = (fnObj) ->
    Haruka.functions.push fnObj

#! ========================================
#! Take Haruka's functions and add them to the queue
HarukaFns = (
    fs.readdirSync './dist/functions'
    .filter (file) -> file.endsWith '.js'
)

for file in HarukaFns
    fnObj = require "../dist/functions/#{file}"
    Haruka.addFunction fnObj


Haruka.try = (msg) ->
    txt = msg.content
    hasRun = no

    #! Check if the message starts with the prefix,
    #! and it's not from another bot.
    if (not txt.startsWith(Haruka.prefix) or msg.author.bot) then return

    args = txt.slice(Haruka.prefix.length).replace(/^\s+/g, '')

    #! Run through all the commands and see if one matches.
    for fn in Haruka.functions
        if hasRun is no
            regexMatch = fn.regex.exec(args)
            if regexMatch
                hasRun = yes
                fn.handler(msg, regexMatch, Haruka)

    #! Catchall
    if not hasRun
        msg.reply [
            "Hmm, I'm not sure what you mean by that."
            "Sorry, I don't know what you meant by that."
            "I’m not sure I understand."
            "I’m not sure what you mean."
        ].choose() + " Try `-h help` for a list of commands."


Haruka.greet = (channelName, member) ->
    #! Send the message to a designated channel on a server
    channel = member.guild.channels.find 'name', channelName
    return if not channel
    channel.send [
        "Welcome to the server, #{member}!"
        # "サーバへようこそ, #{member}さま！"
        "Behold! #{member} has arrived!"
        "A wild #{member} appeared!"
        "The man, the myth, the legend, #{member}!"
        "#{member} joined the party."
    ].choose()

module.exports = Haruka
