#! ========================================
#! Invite
handler = (msg, match, H) ->
    H.client.generateInvite([
        "ADMINISTRATOR", "KICK_MEMBERS", "BAN_MEMBERS"
        "EMBED_LINKS", "READ_MESSAGE_HISTORY", "SEND_MESSAGES"
        "MANAGE_MESSAGES", "ATTACH_FILES"
    ]).then (link) ->
        msg.reply "Invite me to other servers using
            the following link: \n #{link}"

module.exports = {
    name: "Invite"
    regex: /^(invite|link)(\s+|$)/i
    handler: handler
    help:
        short: "-h invite      ::
            Replies with the URL to invite me to other servers."
        long: """
            ```asciidoc
            === Help for Invite ===
            *Aliases*: invite, link
            -h invite :: Replies with the URL to invite me to other servers.
            ```
        """
}
