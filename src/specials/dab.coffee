#! ========================================
#! Dab

handler = (msg, Haruka) ->
    # React with the dabbing emote every time some1 says
    # "dab" or "dabbing" in any server

    # If a message contains "dab" or "dabbing",
    # react with the :rin_dab: emote if it exists
    if /\b(dab(b?ing)?)\b/gi.test msg.content
        rin_dab = msg.guild.emojis.find((e) -> e.name is 'rin_dab')
        if rin_dab? then msg.react rin_dab
        return no

module.exports = {
    name: "Dab"
    handler: handler
}
