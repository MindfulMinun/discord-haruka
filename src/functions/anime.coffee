#! ========================================
#! Anime
Discord = require 'discord.js'
request = require 'request'

asyncReq = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            # coffeelint: disable=max_line_length
            if not err and (200 <= response.statusCode < 400) and not JSON.parse(body)?.errors
                # coffeelint: enable=max_line_length
                return resolve(JSON.parse body)
            reject(err, body)

query = '''
    query ($search: String) {
        Media(search: $search, type: ANIME) {
            title {
                english
                romaji
                native
            }
            description(asHtml: false)
            siteUrl
            episodes
            duration
            genres
            coverImage {
                large
            }
            bannerImage
        }
    }
'''

url = 'https://graphql.anilist.co'

handler = (msg, match, Haruka) ->
    animeRequest = match.input.tokenize()[1]

    if not animeRequest then return msg.reply [
        "Use `-h anime` followed by an anime to search for that anime."
        "I can’t read your mind, tell me what anime you’re looking for."
    ].choose()

    options =
        url: url
        method: 'POST'
        headers:
            'Content-Type': 'application/json'
            'Accept': 'application/json'
        body: JSON.stringify {
            query: query
            variables: search: animeRequest
        }

    asyncReq options
        .then (results) ->
            a = results.data.Media

            desc = do ->
                temp = a.description.split(' ')[...50].join(' ')
                if temp is a.description
                    temp.replace(/<[^>]*>/g, '')
                else
                    temp.replace(/<[^>]*>/g, '') + '...'

            embed = new Discord.RichEmbed()
                .setColor '#448aff'
                .setTitle (
                    a.title.romaji ?
                    a.title.english ?
                    a.title.native
                )
                .setURL a.siteUrl
                .setDescription desc
                .setThumbnail a.coverImage.large
                .setFooter "Powered by the AniList API"

            if a.duration?
                embed.addField("Duration", "#{a.duration} min", yes)

            if a.genres?.length > 0
                embed.addField("Genres", a.genres.join(', '), yes)

            msg.channel.send "Results for “#{animeRequest}”", embed
        .catch (err, body) ->
            console.log ...arguments
            if not body
                msg.channel.send [
                    "Hmm, I couldn’t find that anime. Did you spell it right?"
                ]
            if body.errors
                msg.channel.send """
                    A server error occurred, it's not my fault this time :D
                    
                    ```json
                    #{JSON.stringify body.errors}
                    ```
                """



module.exports = {
    name: "Anime"
    regex: /^(anime|animu|japanime)(\s+|$)/i
    handler: handler
    help:
        short: "-h anime <...> ::
            Retrieves info regarding some anime."
        long: """
            ```asciidoc
            === Help for Anime ===
            *Aliases*: anime, animu, japanime
            -h anime <query> :: Searches for an anime provided a search term.
            ```
        """
}
