#! ========================================
#! About
handler = (msg, match, H) ->
    #! Get rid of extraneous properties
    guildConf = JSON.parse JSON.stringify(
        H.settings.get(msg.guild.id) or H.defaultSettings
    )
    console.log match

    #! Command is admin only, get admin value:
    adminRole = msg.guild.roles.find("name", guildConf.adminRole)

    if not adminRole or not msg.member.has adminRole.id
        return msg.reply [
            "You have to have the `#{guildConf.adminRole}` role
                to use this command."
            "You don't have the `#{guildConf.adminRole}` role,
                so you’re not allowed to use this command."
            "You can’t do that if you don’t have the
                `#{guildConf.adminRole}` role."
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
