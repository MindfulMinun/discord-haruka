#! ========================================
#! Help
handler = (msg, match, H) ->

    helpforCommand = match?[1]?
    if helpforCommand?
        for fn in H.functions
            helpMatch = fn.regex.test helpforCommand
            if helpMatch then return msg.channel.send fn.help.long

    allHelpList = """
        Here’s a list of all my commands. Arguments in `<angle brackets>` \
        are required, and those in `[regular brackets]` are optional.
        For help for a specific command, use `-h help <command>`.
        ```asciidoc
        === Commands ===
        #{
        (fn.help for fn in H.functions)
            .filter (x) -> not x.hidden
            .map (x) -> x.short
            .join '\n'
        }
        ```
    """

    msg.channel.send allHelpList

module.exports = {
    name: "Help"
    regex: /^(?:(?:\s*$)|(?:(?:help|h)(?:\s+(\S[\s\S]*))?))/i
    handler: handler
    help:
        short: "-h help [...]  ::
            This list. What did you expect?"
        long: """
            ```asciidoc
            === Help for Help (so meta) ===
            *Aliases*: help, h
            -h help :: Returns a help menu listing all the commands.
            -h help [command] :: Returns a help menu for that specific command.
            ```
        """
}
