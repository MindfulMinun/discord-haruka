#! ========================================
#! Poll
#! -h poll [<Question?>] [<ans>]
###
 * Syntax: -h poll [Question] [<ans1> <ans2> <ans3> <...>]
 * Ex:     -h poll [Who is best girl?] [<Haruka> <Haruka> <Haruka>]
###

handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]
    msg.reply "My example function. Arguments: `#{args}`"

module.exports = {
    name: "Poll"
    regex: /^(poll)(\s+|$)/i
    handler: handler
    help:
        short: "-h poll        ::
            Does polls."
        long: """
            ```asciidoc
            === Help for Function ===
            *Aliases*: list, of, aliases
            -h fn       :: Function without arguments.
            -h fn <arg> :: Function with arguments.
            ```
        """
}
