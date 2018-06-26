#! ========================================
#! Awoo
###
 * This function is made as a joke reply to timgor's sadbot,
 * which sends [this image](https://imgur.com/gallery/emKQiF4)
 * every night at 2am Eastern (1am Central, 6am UTC)
 *
 * I have to get this right the first time, which is really problematic
###

handler = (msg, Haruka) ->
    # return no
    console.log "#{msg.author.username}\##{msg.author.discriminator}\
        #{if msg.author.bot then "[BOT]" else ""}:
        #{msg.content}"
    if not (
        msg.author.username      is "sadbot" and
        msg.author.discriminator is "3862"   and #! discriminator is a string???
        msg.author.bot           is yes
    ) then return no
    no

module.exports = {
    name: "Awoo"
    handler: handler
}
