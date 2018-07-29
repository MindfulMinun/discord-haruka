#! ========================================
#! Purge
handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]

    if not args then return msg.reply [
        "Please specify the amount of messages to purge."
        "You didn’t specify how many messages to delete."
        "How many messages do you want me to delete?"
    ].choose()

    amount = parseInt(args)

    if not (0 <= amount <= 1000) then return msg.reply [
        "The amount specified must be a positive integer less than 1000."
        "The amount of messages to delete must be a number greater than 0
            and less than 1000."
    ].choose()

    msg.channel.fetchMessages(limit: amount)
    .then (msgs) ->
        msg.channel.bulkDelete msgs
    .then ->
        msg.channel.send [
            "Purged #{amount} messages."
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
            ```
        """
}
