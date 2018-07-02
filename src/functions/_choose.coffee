#! ========================================
#! Choose
handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]
    msg.reply "My example function. Arguments: `#{args}`"

module.exports = {
    name: "Choose"
    regex: /^(choose)(\s+|$)/i
    handler: handler
    help:
        short: "-h choose      ::
            Does something."
        long: """
            ```asciidoc
            === Help for Choose ===
            *Aliases*: list, of, aliases
            -h fn       :: Function without arguments.
            -h fn <arg> :: Function with arguments.
            ```
        """
}
