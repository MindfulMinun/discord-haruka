#! ========================================
#! About
handler = (msg, match, H) ->
    msg.reply "
        Hi, I’m Haruka, your useless bot (`#{H.version}`).
        I’m made out of CoffeeScript and dedication. I was created
        by MindfulMinun, check him out here:\n
        - https://twitter.com/MindfulMinun
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
