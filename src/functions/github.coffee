#! ========================================
#! GitHub

Discord = require 'discord.js'
request = require 'request'

asyncReq = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            if not err and (200 <= response.statusCode < 400)
                return resolve({response, body})
            reject({error, response, body})

#! ========================================
#! Message handler
handler = (msg, match, H) ->
    repo = match.input.tokenize()[1]

    if not repo
        return msg.reply [
            "Use `-h github` followed by GitHub repo you want me to look up."
            "I can look up any GitHub repository if you use
                `-h github` followed by the user or organization, a slash,
                then the repository name."
            "You’re missing a few arguments. Try `-h help github` if
                you forgot this command’s syntax."
        ].choose()


    options = {
        url: "https://api.github.com/repos/" + repo
        method: "GET"
        headers: {
            "User-Agent": "Node.js #{process.version} on Ubuntu 16.04"
            "Content-Type": "application/json"
        }
    }

    asyncReq options
    .then (payload) ->
        data = JSON.parse payload.body

        DateUTC = (date) ->
            #! Formats Dates in a way I hope everyone can understand.
            date ?= new Date()
            date  = new Date(date)
                .toISOString()
                .slice 0, 19
                .replace 'T', ' '
            date + " UTC"

        lastUpdated = DateUTC data.updated_at
        #! coffeelint: disable=max_line_length
        embed = new Discord.RichEmbed()
            .setColor '#448aff'
            .setTitle data.full_name
            .setDescription data.description
            .setURL data.html_url
            .setThumbnail data.owner.avatar_url
            .addField "Language", data.language, yes
            .addField "License", data.license?.name or "None?", yes
            .addField "Default Branch", data.default_branch, yes
            .addField "Last updated", "`#{lastUpdated}`", no
            # .setFooter "All times UTC"
        #! coffeelint: enable=max_line_length
        msg.channel.send embed


module.exports = {
    name: "GitHub"
    regex: /^(github|git)(\s+|$)/i
    handler: handler
    help: """
        ```asciidoc
        === Help for GitHub ===
        *Aliases*: github, git
        -h github <owner/repo> :: Retrieve information about a GitHub repository
        Some examples:
            -h github jquery/jquery
            -h github notwaldorf/tiny-care-terminal
            -h github mindfulminun/discord-haruka
        ```
    """
}
