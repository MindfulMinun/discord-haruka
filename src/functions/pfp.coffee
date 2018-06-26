#! ========================================
#! Profile Image

Discord = require 'discord.js'

handler = (msg, match) ->
    users = msg.mentions.users.array()

    if not users.length then users = [msg.author]

    for user in users
        embed = new Discord.RichEmbed()
            .setColor '#448aff'
            .setURL   user.displayAvatarURL
            .setTitle user.username
            .setDescription "Profile image"
            .setImage user.displayAvatarURL
        msg.channel.send embed

module.exports = {
    name: "Profile Image"
    regex: /^(img|pfp|avatar)(\s+|$)/i
    handler: handler
    help:
        short: "-h pfp [...]   ::
            Returns your (or someone else’s) profile image as a URL"
        long: """
            ```asciidoc
            === Help for Profile Image ===
            *Aliases*: img, pfp, avatar
            -h pfp :: Returns your profile image in a nice box with a URL.
            -h pfp [@user @user ...] :: Returs those user’s profile image.
            Note: You must @ each member directly. @[role], @here, and @everyone
                  won't work.
            ```
        """
}
