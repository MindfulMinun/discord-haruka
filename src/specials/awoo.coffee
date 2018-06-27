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
    if not (
        msg.author.id is "456207047482933251" and
        msg.mentions.everyone is yes
    ) then return no
    ###
     * The if statement above checks if the message
     *     - was from sadbot
     *     - uses @here or @everyone
     * If any statement is false, this Special doesn't execute.
     * I won't check the contents of the message, I'm assuming that since
     * the message mentions @here or @everyone, it's the nightly awoo message.
    ###
    msg.reply [
        "`awOo`"
        "Awoo~"
        ":borntoawoo: awoo >_<"
        ":regional_indicator_a: :regional_indicator_w:
            :regional_indicator_o: :o2:" #! AWOO
    ].choose()
    return yes


module.exports = {
    name: "Awoo"
    handler: handler
}
