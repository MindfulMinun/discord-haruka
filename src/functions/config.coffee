#! ========================================
#! About
handler = (msg, match, H) ->
    db = H.db.serverSettings

    if not msg.guild
        return msg.reply [
            "You have to be in a server to use this command."
            "This command can only be used if you’re in a server."
            "You can’t use this command outside of servers."
        ].choose()

    serverSettings = await (new Promise (s, f) ->
        db.find({_id: "#{msg.guild.id}"}, (err, doc) ->
            if doc then s(doc) else f(err)
        )
    )

    console.log serverSettings

    #! Command is admin only, get admin value:
    adminRole = msg.guild.roles.find("name", serverSettings.adminRole)

    if not adminRole or not msg.member.roles.has adminRole.id
    # if no
        return msg.reply [
            "You have to have the `${guildConf.adminRole}` role
                to use this command."
            "You don't have the `${guildConf.adminRole}` role,
                so you’re not allowed to use this command."
            "You can’t do that if you don’t have the
                `${guildConf.adminRole}` role."
        ].choose()

    #! -h config adminRole admin
    if match[1]
        args = match[1].split(/\s+/g)
        console.log "Arguments: ", args
        if not guildConf.hasOwnProperty args[0]
            return msg.reply [
                "That’s not a valid property."
                "That property isn’t in the configuration file."
                "You can’t set that property, not even with `sudo`."
            ].choose()


    #! -h config
    msg.channel.send """
        Here's the current server configuration:
        ```js
        #{JSON.stringify guildConf, null, 4}
        ```
    """

module.exports = {
    name: "About"
    regex: /^(?:config|c)(?:\s+(\S[\s\S]*))?\s*$/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Config ===
        *Aliases*: None.
        -h config :: Prints the current server configuration.
        ```
    """
}
