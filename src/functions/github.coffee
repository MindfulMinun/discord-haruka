#! ========================================
#! GitHub

Discord = require 'discord.js'
request = require 'request'

asyncReq = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            if not err and (200 <= response.statusCode < 400)
                return resolve({response, body})
            reject({err, response, body})

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
            "User-Agent": require('../package.json').repository
            "Content-Type": "application/json"
        }
    }

    asyncReq options
    .then (payload) ->
        data = JSON.parse payload.body
        console.log data

        stars = (+data.stargazers_count or "None").toLocaleString()
        forks = (+data.forks or "None").toLocaleString()
        issues = (+data.open_issues or "None").toLocaleString()

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
            .addField "Stargazers", stars, yes
            .addField "Forks", forks, yes
            .addField "Open issues", issues, yes
            .setFooter "Last updated"
            .setTimestamp new Date data.updated_at
            # .addField "Last updated", "`#{lastUpdated}`", no
            # .setFooter "All times UTC"
        #! coffeelint: enable=max_line_length
        msg.channel.send embed
    .catch (err) ->
        if err?.response?.statusCode is 404
            msg.reply [
                "That repository wasn’t found. Make sure you’ve spelled
                    the repository name correctly and try again."
                "I couldn’t find that repository. Double-check the repository
                    name and try again."
                "I got a 404 error. Make sure you’ve spelled
                    everything correctly and try again."
            ].choose()
        else
            console.log err
            msg.reply [
                "Sorry, but an unexpected error occurred."
                "An unexpected error ocurred. Sorry about that."
            ].choose()


module.exports = {
    name: "GitHub"
    regex: /^(github|git)(\s+|$)/i
    handler: handler
    help: {
        short: "-h github <..> ::
            Get information on any GitHub repository."
        long: """
            ```asciidoc
            === Help for GitHub ===
            *Aliases*: github, git
            -h github <owner/repo> :: Retrieve information about a GitHub \
            repository
            Some examples:
                -h github lodash/lodash
                -h github MindfulMinun/discord-haruka
                -h github TheTimgor/sadbot
            ```
        """
    }
}
