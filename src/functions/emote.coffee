#! ========================================
#! Emote
execRegex = /^(emote|emoji)(\s+|$)/i
handler = (msg, match, Haruka) ->
    args = match.input.replace(execRegex, '')

    #! Create / Delete
    args = args.split(/\s+/gi)
    switch args[0]
        when "create"
            #! Create emote
            name = args[1]
            image = msg.attachments.array()?[0]?.url or args[2]

            #! Break if no image
            if (not name?) or (not image?)
                return msg.reply "Attachment or URL wasn't provided.
                    Use `-h help emote` for help with this command."

            msg.guild.createEmoji(image, name, null,
                "Haruka: Created emote as asked by
                #{msg.author.username} in Message<#{msg.id}>"
            )
            .then ->
                e = msg.guild.emojis.find((e) -> e.name is name)
                msg.channel.send "Emote created: `:#{name}:`"
                .then (sent) -> sent.react e
            .catch (err) ->
                msg.channel.send "An error occurred: \n```\n#{err}\n```"

        when "delete"
            #! Delete emote
            name = args[1]
            if (not name?)
                return msg.channel.send "
                    An emote name wasn't provided.
                    Please provide an emote name. Use `-h help emote`
                    for help with this command."
            e = msg.guild.emojis.find((e) -> e.name is name)
            if e?
                msg.guild.deleteEmoji(e,
                    "Haruka: Deleted emote as asked by
                    #{msg.author.username} in Message<#{msg.id}>"
                )
                .then ->
                    msg.channel.send "Successfully deleted emote `:#{name}:`"
                .catch (err) ->
                    msg.channel.send "An error occurred: \n```\n#{err}\n```"
            else
                msg.reply [
                    "That emote (`:#{name}:`) doesn’t exist."
                    "I can’t delete an emote that doesn’t exist!"
                    "That emote isn’t from this server."
                ].choose()
        else
            msg.reply "Expected command to be either `create`
                or `delete`, was instead `#{args[0] or "empty"}`.
                Use `-h help emote` for help with this command."
    return

module.exports = {
    name: "Emote"
    regex: execRegex
    handler: handler
    help:
        short: "-h emote <...> ::
            Manages emotes."
        long: """
            ```asciidoc
            === Help for Emote ===
            *Aliases*: emote, emoji
            -h emote create <name> ::
                Creates an emote. This requires an image to be attached.
            -h emote create <name> <url> ::
                Creates an emote with the image located at the URL.
            -h emote delete <name> ::
                Deletes an emote.

            Example:
                -h emote create sayori_hmm https://puu.sh/B0Jgi/4ece28fd9f.jpg
                -h emote delete sayori_hmm
            Note: When using `create`, attachments take precedence.
            ```
        """
}
