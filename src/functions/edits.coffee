#! ========================================
#! Edits
Embed = (require 'discord.js').RichEmbed


genEmbed = (prev) ->
    edits = prev.edits.reverse()
    embed = new Embed()
        .setColor('#448aff')
        .setAuthor(
            prev.author.tag,
            prev.author.displayAvatarURL
        )

    for edit in edits
        time = edit.editedAt ? edit.createdAt
        time = time.toISOString().slice(0, 19).replace('T', ' ') + ' UTC'
        embed.addField(time, edit.content)

    return embed

handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]
    console.log(args)
    [msgId, chId, gldId] = args?.match(/(\d{18})/g)?.reverse() ?
        [null, null, null]
    console.log({msgId, chId, gldId})

    if not msgId
        return msg.reply [
            "Give me a message ID and I'll reveal its previous edits.",
            "This function reveals a message's previous edits given its ID.",
        ].choose() + " Use `-h help edits` for help on getting a message ID."

    guild = Haruka.client.guilds.get(gldId or msg?.guild.id) or msg.guild
    ch = guild?.channels.get(chId) or msg.channel

    ch.fetchMessage(msgId)
        .then (prev) ->
            embed = genEmbed prev
            msg.reply "#{prev.author.tag}’s previous edits: ", embed


module.exports = {
    name: "Edits"
    regex: /^(edits|edit)(\s+|$)/i
    handler: handler
    help:
        short: "-h edits <id>  ::
            Lists a message's previous edits. Expose your friends."
        long: """
            ```asciidoc
            === Help for Edits ===
            *Aliases*: edit, edits

            -h edits <something> :: Lists a message's previous edits
                                    from oldest to newest.

            But what is <something>?

            If you're a normie (this is the easiest way to do it):
                -h edits <url>
                    where <url> is that message's URL (Hover over message ->
                    Click triple dots -> Copy URL)

            If you have developer mode on:
                -h edits <messageID>
                    This syntax assumes you execute the command in the
                    same *channel* and *guild* it was sent.
                -h edits <channelID> <messageID>
                    This syntax assumes you execute the command in the
                    same *server* it was sent but not necessarily the
                    same channel.
                -h edits <guildID> <channelID> <messageID>
                    This lets you execute it anywhere as long as Haruka can
                    read messages from that server.

            Oh, and you can get all of these IDs by right-clicking on the server
            icon, the server channel, and the message respectively. Be sure not
            to copy the user's ID instead of the message's.
            ```
        """
}
