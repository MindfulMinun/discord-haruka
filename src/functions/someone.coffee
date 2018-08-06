#! ========================================
#! Someone
handler = (msg, match, Haruka) ->
    #! Choose a random member
    lucky = msg.channel?.members?.array().choose()

    if lucky?
        msg.channel.send [
            "#{lucky}, you’re the chosen one."
            "#{lucky}, you’ve been summoned."
            "#{lucky}, consider yourself lucky."
        ].choose()

module.exports = {
    name: "Someone"
    regex: /^@?(someone|somebody)(\s+|$)/i
    handler: handler
    help:
        short: "-h @someone    ::
            Mentions a random user."
        long: """
            ```asciidoc
            === Help for Someone ===
            *Aliases*: @someone, @somebody, someone, somebody
            -h someone :: Mentions a random user.
            ```
        """
}
