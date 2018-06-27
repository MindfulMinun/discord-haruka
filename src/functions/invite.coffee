#! ========================================
#! Invite
handler = (msg, match, H) ->
    msg.reply [
        "Invite me to another server using the following link: \n"
        'https://discordapp.com/oauth2/authorize?'
        'client_id='
        H.config.client_id
        '&scope=bot'
        '&permissions='
        '125966'
    ].join ''

#! Permissions:
# Admin, Kick / Ban members, Read msgs, Embed links, Read history,
# Send msgs, Manage msgs, Attach files, View voice channels

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
