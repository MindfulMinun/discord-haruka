#! ========================================
#! xkcd

Discord = require 'discord.js'
request = require 'request'

r = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            shouldResolve = [
                not err,
                200 <= response?.statusCode < 400
            ].every((v) -> v) is yes

            if shouldResolve
                resolve JSON.parse body
            else
                reject response

randomComicNumber = ->
    temp = Math.floor(Math.random() * (latest + 1))
    if (temp is 404) or (temp is 0)
        randomComicNumber()
    else
        temp

# Get the latest comic once, since Haruka sometimes restarts on her own.
latest = 2138
do ->
    latest = (await r 'https://xkcd.com/info.0.json').num


handler = (msg, match, Haruka) ->
    arg = match.input.tokenize()[1] ? ''
    console.log arg
    url = 'https://xkcd.com/'

    switch arg
        when "random" then url += (randomComicNumber() + '/')
        when "" then msg.channel.send 'Latest comic:'
        else url += (arg + '/')
    url += 'info.0.json'

    console.log url

    r(url).then (comic) ->
        embed = new Discord.RichEmbed()
            .setColor '#448aff'
            .setURL "https://xkcd.com/#{comic.num}"
            .setTitle comic.title
            .setImage comic.img
            .setFooter "#{comic.month}/#{comic.day}/#{comic.year}"
        embed.setDescription(comic.alt) if comic.alt?
        # embed.addField('Transcript', comic.transcript) if comic.transcript?
        msg.channel.send embed
    .catch (err) ->
        msg.reply [
            "I couldn't fetch that comic. Sorry."
            "An error occurred while fetching that comic."
        ].choose()

module.exports = {
    name: "xkcd"
    regex: /^(xkcd)(\s+|$)/i
    handler: handler
    help:
        short: "-h xkcd [n]    ::
            Fetches an xkcd comic."
        long: """
            ```asciidoc
            === Help for xkcd ===
            *Aliases*: xkcd
            -h xkcd         :: Fetches the most recent xkcd comic
            -h xkcd [n]     :: Fetches the nth xkcd comic
            -h xkcd random  :: Fetches a random xkcd comic
            ```
        """
}
