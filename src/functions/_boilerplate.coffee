#! ========================================
#! Function name
handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]
    msg.reply "My example function. Arguments: `#{args}`"

module.exports = {
    name: "Function name"
    regex: /^(function|name)(\s+|$)/i
    handler: handler
    help:
        short: "-h ping        ::
            Does something."
        long: """
            ```asciidoc
            === Help for Function ===
            *Aliases*: list, of, aliases
            -h fn       :: Function without arguments.
            -h fn <arg> :: Function with arguments.
            ```
        """
}
