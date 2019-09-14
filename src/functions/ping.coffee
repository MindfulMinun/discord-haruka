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
        p = Haruka.client.ping
        delta = reply.createdTimestamp - msg.createdTimestamp
        reply.edit(
            "#{reply.content} (WebSocket: #{p.toFixed(3)}ms,
                Reaction: #{delta.toFixed(3)}ms,
                Delivery: #{(delta - p).toFixed(3)}ms)"
        )

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
            -h ding :: Replies "Dong!"...
            -h uwu  :: Replies "OwO"...
            -h owo  :: Replies "uwu"...
            -h awoo :: Replies "Awoo!"...
            *Note(s):*
                The WebSocket time is the mean of the last 3 heartbeat
                    pings of Haruka's WebSocket.
                The Reaction time is raw difference between you sending the
                    command and Haruka repling to it.
                The Delivery time is Haruka's Reaction time minus
                    internal evaluation time.
            ```
        """
}
