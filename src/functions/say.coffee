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
        if (
            msg.guild?.id is "443094449233592325" and
            say.match(/@(everyone|here)/gi)
        )
            #! Due to popular demand, any1 who uses @here or
            #! @everyone in tim's server will get kicked.

            # Search for the "WARNED" role
            if msg.member?.roles.find('id', '477135610524598282')
                #! If the member has it, kick them.
                msg.member?.kick("Attempted to mention @everyone with Haruka.")
                    .then ->
                        msg.channel?.send("
                            **Kicked #{msg.author} (#{msg.author.tag})
                            from the server.** Reason: Abusing `-h say`."
                        )
                    .catch (err) ->
                        console.log err
                        msg.channel?.send ("
                            Couldn’t kick #{msg.author}: #{err}"
                        )
            else
                #! If the member doesn’t have the role, add it and warn them.
                msg.member?.addRole('477135610524598282', "Abusing `-h say`")
                    .then ->
                        msg.reply [
                            "Don’t do that. Do it again and you’ll get kicked."
                            "Don’t do that. You’ve been warned."
                        ].choose()

        else
            #! So ppl don’t use `-h say @everyone`
            msg.channel.send "#{say}", disableEveryone: yes

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
