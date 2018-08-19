#! ========================================
#! Ping
handler = (msg, match, Haruka) ->
    msg.reply "Pong!"
    .then (reply) ->
        delta = reply.createdTimestamp - msg.createdTimestamp
        reply.edit("#{reply.content} (#{delta}ms)")

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
            -h ping :: Replies "Pong!" along with the duration it \
                       took Haruka to reply.
            ```
        """
}
