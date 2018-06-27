#! ========================================
#! Creating Haruka

###
 * The message handlers will be passed a snapshot of the Haruka instance.
 * The Haruka instance will have the following structure:

    Haruka {
        dev: Boolean
        functions: [{
            name: String
            regex: RegExp
            handler: Function
            help: String
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
Haruka.dev = no
Haruka.version = "v1.2.0"
Haruka.functions = []
Haruka.specials  = []
Haruka.prefix = if Haruka.dev then '#h' else '-h'

#! ========================================
#! Modules
fs = require 'fs'

#! ========================================
#! Helper functions
Array::choose = ->
    this[Math.floor(Math.random() * this.length)]

Haruka.addFunction = (fnObj) ->
    Haruka.functions.push fnObj

Haruka.addSpecial = (fnObj) ->
    Haruka.specials.push fnObj

#! ========================================
#! Take Haruka's functions and add them to the queue
HarukaFns = (
    fs.readdirSync './dist/functions'
    .filter (file) -> file.endsWith('.js') and not file.startsWith "_"
)

for file in HarukaFns
    fnObj = require "../dist/functions/#{file}"
    Haruka.addFunction fnObj

#! ========================================
#! Take Haruka's special funcitons and add them to the other queue
HarukaFns = (
    fs.readdirSync './dist/specials'
    .filter (file) -> file.endsWith('.js') and not file.startsWith "_"
)

for file in HarukaFns
    fnObj = require "../dist/specials/#{file}"
    Haruka.addSpecial fnObj


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

    #! Show a warning if Haruka's in dev mode
    if Haruka.dev
        msg.reply "I'm in **development** mode, stuff may break.
            Use `#h` instead of `-h`."

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
