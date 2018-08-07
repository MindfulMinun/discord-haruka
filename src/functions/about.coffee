#! ========================================
#! About
handler = (msg, match, H) ->
    msg.reply "
        Hi, I’m Haruka, your useless bot (`#{H.version}`).
        I’m made out of CoffeeScript and dedication. I was created
        by MindfulMinun.\n
        - **Twitter:** https://twitter.com/MindfulMinun\n
        - **GitHub repo:** https://github.com/MindfulMinun/discord-haruka/\n
        - **How I work:** https://benjic.xyz/2018-07-30/haruka-teardown/?s=1
    "

module.exports = {
    name: "About"
    regex: /^(about)(\s+|$)/i
    handler: handler
    help:
        short: "-h about       ::
            General stuff about me."
        long: """
            ```asciidoc
            === Help for About ===
            *Aliases*: None.
            -h about :: Prints some info about me, Haruka!
            ```
        """
}
