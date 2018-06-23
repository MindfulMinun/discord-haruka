#! ========================================
#! Config

###
 * I give up :(
 * Files in /functions/ starting with an underscore
 * won't be pushed to Haruka#functions
###

handler = (msg, match, H) ->
    db = H.db.serverSettings

    console.log match.input.tokenize()

    #! Promiseify db
    getServerSettings = (serverId) ->
        new Promise (resolve, reject) ->
            db.find({_id: serverId}, (err, doc) ->
                if err then reject(err) else resolve(doc)
            )

    if not msg.guild
        return msg.reply [
            "You have to be in a server to use this command."
            "This command can only be used if you’re in a server."
            "You can’t use this command outside of servers."
        ].choose()

    getServerSettings()
    .then (doc) ->
        isntArray = not Array.isArray(doc) or not doc.length

        if isntArray
            doc = H.defaultServerSettings
            doc._id = msg.guild.id
            db.insert doc

        adminRole = msg.guild.roles.find("name", doc.adminRole)
        if not adminRole or not msg.member.roles.has(adminRole.id)
            return msg.reply [
                "You have to have the `#{doc.adminRole}` role
                    to use this command."
                "You don’t have the `#{doc.adminRole}` role,
                    so you’re not allowed to use this command."
                "You can’t do that if you don’t have the
                    `#{doc.adminRole}` role."
            ].choose()

        Object.defineProperty doc, "_id", {
            enumerable: no
        }

        canSetProperty = (obj, prop) ->
            obj.hasOwnProperty(prop) and
            obj.propertyIsEnumerable(prop)

        args = match.input.tokenize()[1]

        if args
            #! Getting / setting
            [prop, val] = args.tokenize()

            if val is undefined
                #! Getting a value
                if canSetProperty(doc, prop)
                    return msg.reply """
                        Don’t break anything.
                        ```js
                        { "#{prop}": #{
                        JSON.stringify(doc[prop])
                        } }
                        ```
                    """
                else throw Error "Haruka: Read not allowed"
            else
                #! Setting a value
                if canSetProperty(doc, prop)
                    #! This part right here is very tricky.
                    #! Get the typeofs of values
                    expectedType = typeof doc[prop]
                    actualType   = typeof JSON.parse val
                    if expectedType isnt actualType
                        throw Error "Haruka: Type mismatch"
                    update = {}; update[prop] = JSON.parse val
                    console.log typeof msg.guild.id
                    console.log update
                    db.update(
                        { _id: msg.guild.id }, update
                    )
                    msg.reply "Updated value."
                else throw Error "Haruka: "

        msg.reply """
            Don’t break anything.
            ```js
            // The configuration for this server: #{msg.guild.name}
            #{JSON.stringify doc, null, 2}
            ```
        """

    .catch (e) ->
        if e.message is "Haruka: Read not allowed"
            return msg.reply [
                "Tough luck, I can’t let you read that property."
                "You can’t read that property. Are you testing me?"
                "You’re not allowed to read that property.
                    You better not be trying to break anything."
            ].choose()
        if e.message.startsWith "Haruka: "
            return msg.reply e.message.tokenize()[1]

        console.log e
        return msg.reply [
            "An unexpected error occurred. If you were setting a value,
                make sure it's formatted correctly in JSON. (i.e., wrap quotes
                around strings.)"
            "Some error occurred. If you were setting a value, make sure
                strings are wrapped in quotes."
        ].choose()

module.exports = {
    name: "Config"
    regex: /^(?:config|c)/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Config ===
        *Aliases*: None.
        -h config :: Prints the current server configuration.
        -h config <key> :: Prints the configuration for that value
        -h config <key> <value> :: Sets a value. Value must be JSON-formatted.
                                   (ex, strings in "quotes", \
                                   booleans: true / false)
        ```
    """
}
