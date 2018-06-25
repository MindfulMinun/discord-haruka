#! ========================================
#! Kanji

Discord = require 'discord.js'
request = require 'request'

asyncReq = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            # coffeelint: disable=max_line_length
            if not err and (200 <= response.statusCode < 400) and not JSON.parse(body).error
                # coffeelint: enable=max_line_length
                return resolve({response, body})
            reject({err, response, body})

handler = (msg, match, H) ->
    kanji = match.input.tokenize()[1]

    # console.log kanji

    options = {
        url: "https://kanjialive-api.p.mashape.com/api/public/kanji/" +
            encodeURI kanji
        method: "GET"
        headers: {
            "X-Mashape-Key": H.config["kanji-alive-api-key"]
            "Content-Type": "application/json"
        }
    }

    asyncReq(options)
    .then (payload) ->
        D = JSON.parse(payload.body)
        K = D.kanji
        R = D.radical
        E = D.examples

        E = E
            .map((v) -> [v.japanese, v.meaning.english].join ': ')[...12]
            .join '\n'

        console.log E

        embed = new Discord.RichEmbed()
            # coffeelint: disable=max_line_length
            .setTitle "#{K.character} — #{K.meaning.english}"
            .setColor '#448aff'
            .setDescription K.meaning.english
            .setURL "https://app.kanjialive.com/" + encodeURI K.character
            .addField "Onyomi",  K.onyomi.katakana, yes
            .addField "Kunyomi", K.kunyomi.hiragana, yes
            .addField "Radical", R.character + "（#{R.name.hiragana or R.name.katakana}）", yes
            .addField "Stroke count", K.strokes.count, yes
            .addField "Examples", E
            # coffeelint: enable=max_line_length
        msg.channel.send embed
    .catch (err) ->
        if JSON.parse(err?.body)?.error is "No kanji found."
            return msg.reply [
                "Couldn’t find Kanji"
                "No results came up for that Kanji."
                "漢字が見つかりません。"
            ].choose()

        msg.reply [
            "An error occurred."
            "Unfortunately, an error occurred."
            "A nasty error occurred."
        ].choose()

module.exports = {
    name: "Kanji"
    regex: /^(kanji)(\s+|$)/i
    handler: handler
    help: {
        short: "-h kanji <...> ::
            Retrieve information about a Kanji character"
        long: """
            ```asciidoc
            === Help for Kanji ===
            *Aliases*: kanji
            -h kanji <kanji> :: Retrieve information about a Kanji \
            character
            ```
        """
    }
}
