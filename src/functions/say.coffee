#! ========================================
#! Say
handler = (msg, match) ->
    say = match.input.tokenize()[1]
    if not say
        msg.reply [
            "Use `-h say` followed by what you want me to say."
            "You have to give me something to say, you can't just say “say.”"
            "Say what?"
            # """
            # ```
            # SyntaxError: Expected 1 argument, saw 0.
            #     at handler             (src/functions/say.coffee:4:20)
            #     at Haruka.addFunction  (src/Haruka.coffee:26:24)
            #     at fn.handler          (src/Haruka.coffee:45:28)
            #     at Haruka.try          (src/Haruka.coffee:29:14)
            #     at client.on 'message' (src/main.coffee:26:16)
            # ```
            # """
        ].choose()
    else
        msg.channel.send "#{say}"

module.exports = {
    name: "Say"
    regex: /^(say|println)(\s+|$)/i
    handler: handler
    help:
        short: "-h say <...>   ::
            Replies with <...>"
        long: """
            ```asciidoc
            === Help for Say ===
            *Aliases*: say, println
            -h say <stuff> :: Replies with <stuff>
            ```
        """
}
