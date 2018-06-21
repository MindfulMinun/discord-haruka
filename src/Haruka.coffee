#! ========================================
#! Creating Haruka
Haruka = {}
Haruka.dev = yes
Haruka.functions = []
Haruka.prefix = if Haruka.dev then '#h' else '-h'

#! ========================================
#! Modules
fs        = require 'fs'
Datastore = require 'nedb'

#! ========================================
#! Datastores
Haruka.db = {
    serverSettings: new Datastore {
        filename: 'data/serverSettings.db'
        autoload: yes
    }
}

Haruka.defaultServerSettings = {
    modRole: "mod"
    adminRole: "admin"
    welcomeChannel: "welcome"
    shouldWelcomeNewMembers: yes
    # welcomeMessage: [
    #     "Welcome to the server, {member}!"
    #     # "サーバへようこそ, {member}さま！"
    #     "Behold! {member} has arrived!"
    #     "A wild {member} appeared!"
    #     "The man, the myth, the legend, {member} has arrived!"
    #     "{member} joined the party."
    # ]
}

#! Compact database every hour
# Haruka.db.persistence.setAutocompactionInterval 3.6e+6

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

    #! Arguments = "-h    my command" -> "my command"
    args = txt.slice(Haruka.prefix.length).replace(/^\s+/g, '')

    #! Show a warning if Haruka's in dev mode
    if Haruka.dev
        msg.reply "I'm in **development** mode, stuff may break.
            Use `#h` instead of `-h`."

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

module.exports = Haruka
