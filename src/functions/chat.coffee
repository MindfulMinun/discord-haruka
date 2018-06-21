#! ========================================
#! Chat

handler = (msg) ->
    msg.channel.send [
        "I’m so excited for the new Smash Bros. game coming out this December!
            Apparently, the game’s going to include all characters from
            previous Smash series. The only _new_ characters they’ve annnounced
            are Daisy, Ridley, and Inkling, so does that kill any hopes of
            any more fighters being revealed, excluding DLC?"
    ].choose()

module.exports = {
    name: "Chat"
    regex: /^(chat|talk|banter)/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Chat ===
        *Aliases*: chat, talk, banter
        -h chat :: Start a conversation with me!
        ```
    """
}
