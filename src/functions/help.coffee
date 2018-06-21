#! ========================================
#! Help
handler = (msg, match, H) ->

    if match[1]
        for fn in H.functions
            helpMatch = fn.regex.test match[1]
            if helpMatch then return msg.channel.send fn.help

    msg.channel.send """
        Here's a list of all my commands. Arguments in `<angle brackets>` \
        are required, and those in `[regular brackets]` are optional.
        For help for a specific command, use `-h help <command>`.
        ```asciidoc
        === Commands ===
        about      :: General stuff about me.
        chat       :: Start a conversation with me!
        help [...] :: This list. What did you expect?
        invite     :: Replies with the URL to invite me to other servers.
        pfp        :: Returns your profile image as a URL
        ping       :: Replies “Pong!”
        pkmn <...> :: Get information regarding a Pokémon (Try -h help pkmn)
        say <...>  :: Replies with <...>
        ```
    """

module.exports = {
    name: "Help"
    regex: /^(?:help|h)(?:\s+(\S[\s\S]*))?\s*$/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Help (so meta) ===
        *Aliases*: help, h
        -h help :: Returns a help menu listing all the commands.
        -h help [command] :: Returns a help menu for that specific command.
        ```
    """
}
