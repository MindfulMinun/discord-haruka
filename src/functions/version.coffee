#! ========================================
#! Version
Discord = require 'discord.js'
relative = require "#{__dirname}/../helpers/relative"

formattedTime = (secs) ->
    h = ~~(secs / 3600)
    m = ~~((secs % 3600) / 60)
    s = ~~(secs % 60)
    r = ""

    r += "#{h}:" + (if m < 10 then '0' else '')
    r += "#{m}:" + (if s < 10 then '0' else '')
    r += s
    r

handler = (msg, match, H) ->
    chosenBlob = H.config.about.blobs.choose()
    if Array.isArray chosenBlob then chosenBlob = chosenBlob.choose()

    embed = new Discord.RichEmbed()
        .setColor '#448aff'
        .setTitle "Haruka #{H.version}"
        .addField "Uptime", "
            #{formattedTime(H.client.uptime / 1000)} •
            Started #{relative(new Date() - H.client.uptime).toLowerCase()}
        "
        .addField "Function counts", "
            #{H.functions.length} functions,
            #{H.specials.length} specials.
        "
        .addField "Functions", "
            #{H.functions.map((f) -> f.name).join(', ')}
        "
        .addField "Specials", "
            #{H.specials.map((f) -> f.name).join(', ')}
        "
        .addField "Server count", "
            In #{H.client.guilds.size} servers
        "
        .setFooter "#{H.config.name}@#{H.version}"
        .setTimestamp H.client.readyAt
    msg.channel.send embed

module.exports = {
    name: "Version"
    regex: /^(version|v|stats)(\s+|$)/i
    handler: handler
    help:
        hidden: yes
        long: """
            ```asciidoc
            === Help for Version ===
            *Aliases*: version, v, stats
            -h version  :: Prints out technical information about Haruka.
            ```
        """
}
