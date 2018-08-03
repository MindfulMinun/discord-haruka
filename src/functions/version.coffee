#! ========================================
#! Function name
handler = (msg, match, H) ->
    msg.reply "Running Haruka `#{H.version}`
        #{if H.dev then "(Development mode)" else ""},
        with #{H.functions.length} functions and
        #{H.specials.length} specials."

module.exports = {
    name: "Version"
    regex: /^(version|v)(\s+|$)/i
    handler: handler
    help:
        hidden: yes
        short: ""
        long: """
            ```asciidoc
            === Help for Version ===
            *Aliases*: version, v
            -h version  :: Prints out version information about Haruka.
            ```
        """
}
