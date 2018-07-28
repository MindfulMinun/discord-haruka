#! ========================================
#! Dab

handler = (msg, Haruka) ->
    # React with the dabbing emote every time some1 says
    # "dab" or "dabbing" in timgor's server

    # Check if the message was sent from tim's server
    # Check if the message includes "dab" or "dabbing"
    if msg.guild.id isnt "443094449233592325" then return

    # If a message contains "dab" or "dabbing", react with the :rin_dab: emote
    if /\b(dab(bing)?)\b/gi.test msg.content
        rin_dab = msg.guild.emojis.find('name', 'rin_dab')
        msg.react rin_dab
        return true

module.exports = {
    name: "Dab"
    handler: handler
}
