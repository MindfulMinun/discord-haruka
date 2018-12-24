#! ========================================
#! Anime
Discord = require 'discord.js'
request = require 'request'
relative = require "#{__dirname}/../helpers/relative"

asyncReq = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            # coffeelint: disable=max_line_length
            if not err and (200 <= response.statusCode < 400) and not JSON.parse(body)?.errors
                # coffeelint: enable=max_line_length
                return resolve(JSON.parse body)
            reject [err, response, body]

query = '''
    query ($search: String) {
        Media(search: $search, type: ANIME) {
            title {
                english
                romaji
                native
            }
            description(asHtml: false)
            averageScore
            nextAiringEpisode {
                airingAt
            }
            status
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

            status = [
                "FINISHED", "RELEASING", "NOT_YET_RELEASED", "CANCELLED"
            ].indexOf a.status

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

            if a.episodes?
                embed.addField("Number of Episodes", "#{a.episodes}", yes)

            if a.averageScore?
                embed.addField("Score", "#{a.averageScore} out of 100", yes)

            if status isnt -1
                status = switch status
                    when 0 then "Completed"
                    when 1 then "Currently airing"
                    when 2 then "Not yet airing"
                    when 3 then "Cancelled"
                embed.addField("Status", status, yes)

            if a.nextAiringEpisode?.airingAt?
                nextAiringDate = new Date a.nextAiringEpisode.airingAt * 1000
                embed.addField("Next episode airs...", "#{
                    relative nextAiringDate
                }", yes)

            if a.genres?.length > 0
                embed.addField("Genres", a.genres.join(', '), yes)

            msg.channel.send("Results for “#{animeRequest}”", {
                disableEveryone: yes,
                embed: embed
            })
        .catch (err) ->
            [err, response, body] = err
            console.log ...arguments
            if not body
                return msg.channel.send [
                    "Hmm, I couldn’t find that anime. Did you spell it right?"
                ]
            if body?.errors
                return msg.channel.send """
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
