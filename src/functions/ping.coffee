#! ========================================
#! Ping
handler = (msg) -> msg.reply "Pong!"

module.exports = {
    name: "Ping"
    regex: /^(ping|pong|beep|boop|ding|dong)/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Ping ===
        *Aliases*: ping, pong, beep, boop, ding, dong
        -h ping :: Replies "Pong!", nothing fancy.
        ```
    """
}
