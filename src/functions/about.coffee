#! ========================================
#! About
handler = (msg) ->
    msg.reply "
        Hi, I’m Haruka, your useless bot. I'm made out of CoffeeScript
        and dedication. I was created by MindfulMinun, check him out here:\n
        - https://twitter.com/MindfulMinun
    "

module.exports = {
    name: "About"
    regex: /^about/i
    handler: handler
    help: """
        ```asciidoc
        === Help for About ===
        *Aliases*: None.
        -h about :: Prints some info about me, Haruka!
        ```
    """
}
