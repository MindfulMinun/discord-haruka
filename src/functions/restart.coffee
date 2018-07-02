#! ========================================
#! Restart
handler = (msg, match, Haruka) ->
    force = match.input.tokenize()[1]

    if msg.author.id in Haruka.config.ops
        if /^(-f|--force)$/.test force
            return msg.reply [
                "Halting..."
                "brb calling `process.exit()`"
                "i'm dead"
            ].choose()
            .then -> process.exit()
        else
            return msg.reply "
                Halting is a really dangerous command. Calling it will halt the
                Haruka proccess, #h help hand Haruka may not be restarted
                automatically. Furthermore, debug logs will be deleted. If you
                understand what you're actually doing, please run
                `-h halt --force` or `-h halt -f`.
            "

    msg.reply [
        "You’re not an op, so I can’t let you do that."
        "You can’t do that if you’re not an op."
        "I refuse to let myself be controlled
            by the likes of you."
    ].choose()

module.exports = {
    name: "Halt"
    regex: /^(halt|restart)(\s+|$)/i
    handler: handler
    help:
        hidden: yes
        short: ""
        long: """
            ```asciidoc
            === Help for Halt ===
            *Aliases*: halt, restart
            -h halt :: Halts Haruka \
            (Must have super-rare™ permissions)
            ```
        """
}
