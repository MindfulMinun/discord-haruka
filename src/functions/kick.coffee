#! ========================================
#! Kick
handler = (msg, match, Haruka) ->

    members = msg.mentions.members

    if not members.size
        return msg.reply [
            "Do you even know how to use this command...?"
            "Don’t use such a powerful command if you
                don’t know how to use it."
        ].choose()

    canKickAll = members.every (member) ->
        # Override permissions if the executor is an op.
        member.kickable or (msg.author.id in Haruka.config.ops)

    if canKickAll
        members.tap (member) ->
            member.kick()
                .then ->
                    msg.channel.send [
                        "Nice, I kicked #{member} successfully."
                        "Cool, #{member} was kicked."
                        "Bye bye, #{member}, you've been kicked."
                    ].choose()
                .catch (err) ->
                    msg.reply [
                        "Heck, I couldn't do that."
                        "Something happened."
                        "Dang, I wasn't able to do that."
                    ].choose() + "\n```#{err}```"
    else
        msg.reply [
            "You think you can do that? Nice try."
            "I refuse to run that command."
            "Who do you think you are, a mod?"
        ].choose()

module.exports = {
    name: "Kick"
    regex: /^(kick|eject)(\s+|$)/i
    handler: handler
    help:
        short: "-h kick        ::
            Kicks mentioned users."
        hidden: true
        long: """
            ```asciidoc
            === Help for kick ===
            *Aliases*: kick, eject
            -h kick <user...> :: Kicks all the mentioned users.
            Example:
                -h kick @MindfulMinun @Haruka
            Note: Both you and I must be able to kick *all* mentioned users.
                  This function fails even if only 1 member can't be kicked.
            ```
        """
}
