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
        -h about      :: General stuff about me.
        -h chat       :: Start a conversation with me!
        -h help [...] :: This list. What did you expect?
        -h invite     :: Replies with the URL to invite me to other servers.
        -h pfp        :: Returns your profile image as a URL
        -h ping       :: Replies “Pong!”
        -h pkmn <...> :: Get information regarding a Pokémon (Try -h help pkmn)
        -h say <...>  :: Replies with <...>
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
