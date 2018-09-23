#! ========================================
#! Version
Discord = require 'discord.js'

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
        .addField "Uptime", formattedTime(H.client.uptime / 1000)
        .setFooter "#{H.config.name}@#{H.version}"
        .setTimestamp H.client.readyAt
    msg.channel.send embed

module.exports = {
    name: "Version"
    regex: /^(version|v)(\s+|$)/i
    handler: handler
    help:
        hidden: yes
        long: """
            ```asciidoc
            === Help for Version ===
            *Aliases*: version, v
            -h version  :: Prints out technical information about Haruka.
            ```
        """
}
