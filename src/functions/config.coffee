#! ========================================
#! Config
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
        if not adminRole or not msg.member.roles.has adminRole.id
            return msg.reply [
                "You have to have the `#{doc.adminRole}` role
                    to use this command."
                "You don’t have the `#{doc.adminRole}` role,
                    so you’re not allowed to use this command."
                "You can’t do that if you don’t have the
                    `#{doc.adminRole}` role."
            ].choose()

        Object.defineProperty doc, "_id", {
            value: doc._id
            enumerable: no
        }

        canSetProperty = (obj, prop) ->
            obj.hasOwnProperty(prop) and
            obj.propertyIsEnumerable(prop)

        args = match.input.tokenize()[1]

        if Array.isArray(args) and args.length
            args = args.tokenize()
            if args.length is 1
                #! Getting a value
                if canSetProperty(doc, "#{args[0]}")
                    return msg.reply """
                        Don’t break anything.
                        ```js
                        {
                          "#{args[0]}": #{JSON.stringify doc[args[0]], null, 2}
                        }
                        ```
                    """
                else
                    #! Can't read property
                    return msg.reply [
                        "Tough luck, I can’t let you read that property."
                        "You can’t read that property. Are you testing me?"
                        "You’re not allowed to read that property.
                            You better not be trying to break anything."
                    ].choose()
            else
                #! Args.length is 2
                #! Setting a value
                if canSetProperty(doc, "#{args[0]}")
                    #! This part right here is very tricky.
                    #! Get the typeofs of values
                    expectedType = typeof docs[args[0]]
                    actualType   = typeof JSON.parse args[1]

                    if expectedType isnt actualType
                        return msg.reply [
                            "I expected #{args[0]} to be of type
                                #{typeof docs[args[0]]}, was instead
                                #{typeof args[1]}."
                        ].choose()



                    return msg.reply """
                        Set property `#{args[0]}` to `#{JSON.parse args[1]}`.
                        ```js
                        {
                          "#{args[0]}": #{JSON.stringify doc[args[0]], null, 2}
                        }
                        ```
                    """
                else
                    #! Can't read property
                    return msg.reply [
                        "Tough luck, I can’t let you set that property."
                        "You can’t set that property. Are you testing me?"
                        "You’re not allowed to set that property.
                            You better not be trying to break anything."
                    ].choose()


        msg.reply """
            Don’t break anything.
            ```js
            // The configuration for this server: #{msg.guild.name}
            #{JSON.stringify doc, null, 2}
            ```
        """

    .catch (err) ->
        console.log err
        return msg.reply [
            "An unexpected error occurred. If you were setting a value,
                make sure it's formatted correctly in JSON. (i.e., wrap quotes
                around strings.)"
            "Some error occurred. If you were setting a value, make sure
                you "
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
                                   (ex, strings in "quotes", booleans: true / false)
        ```
    """
}
