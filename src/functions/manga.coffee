#! ========================================
#! Manga

# NOTE: This code is pretty much a duplicate of `anime.coffee`
# any changes made here should reflect `anime` as well.

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
        Media(search: $search, type: MANGA) {
            title {
                english
                romaji
                native
            }
            description(asHtml: false)
            averageScore
            status
            siteUrl
            chapters
            volumes
            genres
            coverImage {
                large
            }
            bannerImage
            synonyms
        }
    }
'''

url = 'https://graphql.anilist.co'

handler = (msg, match, Haruka) ->
    mangaRequest = match.input.tokenize()[1]

    if not mangaRequest then return msg.reply [
        "Use `-h manga` followed by an manga to search for that manga."
    ].choose()

    options =
        url: url
        method: 'POST'
        headers:
            'Content-Type': 'application/json'
            'Accept': 'application/json'
        body: JSON.stringify {
            query: query
            variables: search: mangaRequest
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

            if a.chapters?
                embed.addField("Chapter count", "#{a.chapters}", yes)

            if a.volumes?
                embed.addField("Volume count", "#{a.volumes}", yes)

            if a.averageScore?
                embed.addField("Score", "#{a.averageScore} out of 100", yes)

            if status isnt -1
                status = switch status
                    when 0 then "Completed"
                    when 1 then "Currently releasing"
                    when 2 then "Not yet released"
                    when 3 then "Canceled"
                embed.addField("Status", status, yes)

            if a.synonyms?.length > 0
                embed.addField("Alternate names", a.synonyms.join(', '), yes)

            if a.genres?.length > 0
                embed.addField("Genres", a.genres.join(', '), yes)

            msg.channel.send("Results for “#{mangaRequest}”", {
                disableEveryone: yes,
                embed: embed
            })
        .catch (err) ->
            console.log err
            response = null
            body = null
            if err instanceof Array
                [err, response, body] = err
            if not body
                return msg.channel.send [
                    "Hmm, I couldn’t find that manga. Did you spell it right?"
                ]
            if body?.errors
                return msg.channel.send """
                    A server error occurred, it's not my fault this time :D

                    ```json
                    #{JSON.stringify body.errors}
                    ```
                """



module.exports = {
    name: "Manga"
    regex: /^(manga|doujin)(\s+|$)/i
    handler: handler
    help:
        short: "-h manga <...> ::
            Retrieves info regarding some manga."
        long: """
            ```asciidoc
            === Help for Manga ===
            *Aliases*: manga, doujin
            -h manga <query> :: Searches for a mange provided a search term.
            ```
        """
}
