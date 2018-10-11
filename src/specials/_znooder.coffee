#! ========================================
#! Znooder-snoozer: Mutes any message from Discord user znooder#6987

handler = (msg, Haruka) ->
    if msg.author.id is "120719403015864324"
        msg.delete().then ->
            msg.channel.send [
                '*znooder has been snoozed*'
                '*znooder has been snoozed* :)'
            ].choose()

module.exports = {
    name: "Znooder-snoozer"
    handler: handler
}
