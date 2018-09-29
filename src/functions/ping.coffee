#! ========================================
#! Ping
handler = (msg, match, Haruka) ->
    input = match[1].toLowerCase()

    (switch input
        when "ping" then msg.reply "Pong!"
        when "beep" then msg.reply "Boop!"
        when "ding" then msg.reply "Dong!"
        when "awoo" then msg.reply "Awoo!"
        when "uwu" then msg.reply "OwO"
        when "owo" then msg.reply "uwu"
        else msg.reply "Pong!"
    ).then (reply) ->
        delta = reply.createdTimestamp - msg.createdTimestamp
        reply.edit("#{reply.content} (#{delta}ms)")

module.exports = {
    name: "Ping"
    regex: /^(ping|beep|ding|uwu|owo|awoo)!?(\s+|$)/i
    handler: handler
    help:
        short: "-h ping        ::
            Replies “Pong!”"
        long: """
            ```asciidoc
            === Help for Ping ===
            *Aliases*: ping, beep, ding, owo, uwu, awoo
            -h ping :: Replies "Pong!" along with the time it took to reply.
            -h beep :: Replies "Boop!" along with the time it took to reply.
            -h ding :: Replies "Dong!" along with the time it took to reply.
            -h uwu  :: Replies "OwO" along with the time it took to reply.
            -h owo  :: Replies "uwu" along with the time it took to reply.
            -h awoo :: Replies "Awoo!" along with the time it took to reply.
            ```
        """
}
