#! ========================================
#! Profile Image

Discord = require 'discord.js'

handler = (msg) ->
    console.log msg
    embed = new Discord.RichEmbed()
        .setColor '#448aff'
        .setURL   msg.author.displayAvatarURL
        .setTitle msg.author.username
        .setDescription "Profile image"
        .setImage msg.author.displayAvatarURL
    msg.channel.send embed

module.exports = {
    name: "Profile Image"
    regex: /^(my\s+)?(img|pfp|avatar)/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Profile Image ===
        *Aliases*: my img, my pfp, my avatar, img, pfp, avatar
        -h pfp :: Returns your profile image in a nice box with a URL.
        ```
    """
}
