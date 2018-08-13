#! ========================================
#! Latin to fullwidth maps
latin = [
    '!"#$%&\'()*+,-./'
    '0123456789:;<=>?'
    '@ABCDEFGHIJKLMNO'
    'PQRSTUVWXYZ[\\]^_'
    '`abcdefghijklmno'
    'pqrstuvwxyz{|}~'
    '¢£¥• '
].join ''
fullwidth = [
    '！＂＃＄％＆＇（）＊＋，－．／'
    '０１２３４５６７８９：；＜＝＞？'
    '＠ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯ'
    'ＰＱＲＳＴＵＶＷＸＹＺ［＼］＾＿'
    '｀ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏ'
    'ｐｑｒｓｔｕｖｗｘｙｚ｛｜｝～'
    '￠￡￥・　'
].join ''

#! ========================================
#! Converter
toFullwidth = (txt) ->
    #! Match any character...
    String(txt).replace(/[\s\S]+?/g, (match, pos, string) ->
        i = latin.indexOf match
        if i isnt -1
            #! If it's in the latin set, replace it with it's
            #! fullwidth equivalent
            fullwidth[i]
        else
            #! If not, just return that character ¯\_(ツ)_/¯
            match
    )

#! ========================================
#! Aesthetic
handler = (msg, match, Haruka) ->
    txt = msg.cleanContent.replace(
        new RegExp("^(#{Haruka.prefix})\\s+(aesthetic|wide|ae)\\s+", 'i'),
        ''
    )
    if not txt? then return msg.channel.send [
        "Function was called without sufficient arguments."
        "Use `-h help aesthetic` for help on this function."
        "Use `-h aesthetic` followed by whatever
            you want me to “aesthetic-ize”."
        # """
        # ```
        # SyntaxError: Expected 1 argument, saw 0.
        #     at handler             (src/functions/aesthetic.coffee:4:20)
        #     at Haruka.addFunction  (src/Haruka.coffee:26:24)
        #     at fn.handler          (src/Haruka.coffee:45:28)
        #     at Haruka.try          (src/Haruka.coffee:29:14)
        #     at client.on 'message' (src/main.coffee:26:16)
        # ```
        # """
    ].choose()
    msg.channel.send toFullwidth txt

module.exports = {
    name: "Aesthetic"
    regex: /^(aesthetic|wide|ae)(\s+|$)/i
    handler: handler
    help:
        short: "-h ae <text>   ::
            Makes your text more ａｅｓｔｈｅｔｉｃ."
        long: """
            ```asciidoc
            === Help for Aesthetic ===
            *Aliases*: aesthetic, wide, ae
            -h aesthetic <text> :: Converts <text> into fullwidth characters.
            ```
        """
}
