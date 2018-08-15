#! ========================================
#! Someone
handler = (msg, match, Haruka) ->
    #! Choose a random member
    if not msg.guild? then return msg.reply [
        "You have to be in a server to use this command."
        "This command only works in servers, not DMs or GroupDMs."
        "It doesn’t look like you’re in a server, so I can’t run that command."
    ].choose()

    args = match.input.tokenize()[1]
    members = msg.channel?.members
    lucky = switch args
        when "online"
            members?.filter((m) -> m?.presence.status is 'online')
        when "offline"
            members?.filter((m) -> m?.presence.status is 'offline')
        when "dnd"
            members?.filter((m) -> m?.presence.status is 'dnd')
        when "idle"
            members?.filter((m) -> m?.presence.status is 'idle')
        else
            members?.filter((m) -> m?.presence.status in ['online', 'idle'])

    if lucky = lucky.random()
        msg.channel.send [
            "#{lucky}, you’re the chosen one."
            "#{lucky}, you’ve been summoned."
            "#{lucky}, consider yourself lucky."
        ].choose()
    else
        msg.reply [
            "Hmm, I couldn’t choose a random user who’s `#{args ? 'online'}`."
            "I can’t seem to find someone with those criteria."
            "I didn’t find anyone who’s `#{args ? 'online'}`."
        ].choose() + " See `-h h someone` for details on this command."

module.exports = {
    name: "Someone"
    regex: /^@?(someone|somebody)(\s+|$)/i
    handler: handler
    help:
        # P for presence
        short: "-h someone [p] ::
            Mentions a random user."
        long: """
            ```asciidoc
            === Help for Someone ===
            *Aliases*: @someone, @somebody, someone, somebody
            -h someone         :: Mentions a random user that’s online.
            -h someone online  :: Mentions a random user that’s online.
            -h someone offline :: Mentions a random user that’s offline.
            -h someone idle    :: Mentions a random user that’s idle.
            -h someone dnd     :: Mentions a random user that’s \
                in Do Not Disturb.
            *Note*: This function only works in servers, not DMs or GroupDMs.
            ```
        """
}
