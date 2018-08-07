#! ========================================
#! Purge
handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]

    # First, check if the user can even delete messages
    allowed = (
        msg.member?.permissionsIn(msg.channel)?.has("MANAGE_MESSAGES")
    )

    if not allowed then return msg.channel.send [
        "You don’t have permission to manage messages
            in this channel, #{msg.author}."
        "#{msg.author}, You can’t do that, you don’t have permissions to do so."
        "Sorry #{msg.author}, but you’re not allowed to delete messages."
    ].choose()

    # 2nd, check if quantity was specified and if it's within 0 and 1000
    if not args then return msg.reply [
        "Please specify the amount of messages to purge."
        "You didn’t specify how many messages to delete."
        "How many messages do you want me to delete?"
    ].choose()

    amount = parseInt(args)

    if not (1 <= amount <= 1000) then return msg.reply [
        "The amount specified must be a positive integer less than 1000."
        "The amount of messages to delete must be a number greater than
            0 and less than or equal to 1000."
    ].choose()

    msg.channel.fetchMessages(limit: amount)
    .then (msgs) ->
        msg.channel.bulkDelete msgs
    .then ->
        msg.channel.send [
            "#{msg.author}, I deleted #{amount} messages."
            "#{msg.author}, Deleted #{amount} messages successfully."
            "Purged #{amount} messages as requested by #{msg.author}"
        ].choose()
    .catch (err) ->
        msg.channel.send "Failed to delete messages: \n```\n#{err}\n```"

module.exports = {
    name: "Purge"
    regex: /^(purge|delete)(\s+|$)/i
    handler: handler
    help:
        short: "-h purge <n>   ::
            Deletes messages in bulk."
        long: """
            ```asciidoc
            === Help for Purge ===
            *Aliases*: purge, delete
            -h purge <amount> :: Deletes specified amount of \
                messages in that channel.
            *Note:* Both you and I must have permission to delete messages.
            ```
        """
}
