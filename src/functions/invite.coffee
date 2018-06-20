#! ========================================
#! Invite
config = require '../config.json'
handler = (msg) ->
    msg.reply [
        "Invite me to another server using the following link: \n"
        'https://discordapp.com/oauth2/authorize?'
        'client_id='
        config.client_id
        '&scope=bot'
    ].join ''

module.exports = {
    name: "Invite"
    regex: /^(invite|link)/i
    handler: handler
    help: """
        ```asciidoc
        === Help for Invite ===
        *Aliases*: invite, link
        -h invite :: Replies with the URL to invite me to other servers.
        ```
    """
}
