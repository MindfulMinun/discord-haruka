#! ========================================
#! Say
handler = (msg, match) ->
    if not match[1]
        msg.reply [
            "Use `-h say` followed by what you want me to say."
            "You have to give me something to say, you can't just say “say.”"
            "Say what?"
            """
            ```coffee
            ###
            SyntaxError: Expected 1 argument, saw 0.
                at handler             (src/functions/say.coffee:4:20)
                at Haruka.addFunction  (src/Haruka.coffee:26:24)
                at fn.handler          (src/Haruka.coffee:45:28)
                at Haruka.try          (src/Haruka.coffee:29:14)
                at client.on 'message' (src/main.coffee:26:16)
            ###
            ```
            """
        ].choose()
    else
        msg.channel.send "#{match[1]}"

module.exports = {
    name: "Say"
    regex: /^(?:say|println)\s*(\S[\s\S]*)?/i
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
