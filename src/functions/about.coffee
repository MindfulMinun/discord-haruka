#! ========================================
#! About
Discord = require 'discord.js'

handler = (msg, match, H) ->
    chosenBlob = H.config.about.blobs.choose()
    if Array.isArray chosenBlob then chosenBlob = chosenBlob.choose()

    embed = new Discord.RichEmbed()
        .setColor '#448aff'
        .setTitle "Haruka #{H.version}"
        .setDescription H.config.about.description
        .addField "Links", H.config.about.links
        .setFooter "#{chosenBlob}"
        .setTimestamp H.client.readyAt
    msg.channel.send embed

module.exports = {
    name: "About"
    regex: /^(about)(\s+|$)/i
    handler: handler
    help:
        short: "-h about       ::
            General stuff about me."
        long: """
            ```asciidoc
            === Help for About ===
            *Aliases*: None.
            -h about :: Prints some info about me, Haruka!
            ```
        """
}
