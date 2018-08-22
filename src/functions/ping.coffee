#! ========================================
#! Ping
handler = (msg, match, Haruka) ->
    input = match[1].toLowerCase()

    (switch input
        when "ping" then msg.reply "Pong!"
        when "beep" then msg.reply "Boop!"
        when "ding" then msg.reply "Dong!"
        else msg.reply "Pong!"
    ).then (reply) ->
        delta = reply.createdTimestamp - msg.createdTimestamp
        reply.edit("#{reply.content} (#{delta}ms)")

module.exports = {
    name: "Ping"
    regex: /^(ping|beep|ding)(\s+|$)/i
    handler: handler
    help:
        short: "-h ping        ::
            Replies “Pong!”"
        long: """
            ```asciidoc
            === Help for Ping ===
            *Aliases*: ping, beep, ding
            -h ping :: Replies "Pong!" along with the time it took to reply.
            -h beep :: Replies "Boop!" along with the time it took to reply.
            -h ding :: Replies "Dong!" along with the time it took to reply.
            ```
        """
}
