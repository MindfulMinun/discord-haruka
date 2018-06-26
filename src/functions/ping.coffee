#! ========================================
#! Ping
handler = (msg) -> msg.reply "Pong!"

module.exports = {
    name: "Ping"
    regex: /^(ping|pong|beep|boop|ding|dong)(\s+|$)/i
    handler: handler
    help:
        short: "-h ping        ::
            Replies “Pong!”"
        long: """
            ```asciidoc
            === Help for Ping ===
            *Aliases*: ping, pong, beep, boop, ding, dong
            -h ping :: Replies "Pong!", nothing fancy.
            ```
        """
}
