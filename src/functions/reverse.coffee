#! ========================================
#! Reverse
handler = (msg, match, Haruka) ->
    txt = match.input.tokenize()[1]
    txt = msg.cleanContent.replace(
        new RegExp("^(#{Haruka.prefix})\\s+(reverse|backwards)\\s+", 'i'),
        ''
    )
    if not txt
        msg.reply [
            'Reverse what?'
            '?tahw esreveR'
            'What do you want me to reverse?'
            '?esrever ot em tnaw uoy od tahW'
            'Give me some text to reverse.'
            '.esrever ot txet emos em eviG'
        ].choose()
    else
        txt = txt.split('').reverse().join('')
        msg.channel.send txt, disableEveryone: yes

module.exports = {
    name: "Reverse"
    regex: /^(reverse|backwards)(\s+|$)/i
    handler: handler
    help:
        short: "-h reverse <t> ::
            Reverses some text."
        long: """
            ```asciidoc
            === Help for Reverse ===
            *Aliases*: reverse, backwards
            -h reverse <text> :: Sends the text but in reverse.
            ```
        """
}
