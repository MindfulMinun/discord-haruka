#! ========================================
#! usercount
handler = (msg, match, H) ->
    msg.reply "This command isn’t implemented yet."

module.exports = {
    name: "usercount"
    # regex: /^(?:usercount)(?:\s+(\S[\s\S]*))?\s*$/i
    regex: /^(?:usercount)/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Usercount ===
        *Aliases*: None.
        // This command isn’t fully implemented yet.
        ```
    """
}
