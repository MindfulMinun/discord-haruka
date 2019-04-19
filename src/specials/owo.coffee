#! ========================================
#! Special: owo

handler = (msg, Haruka) ->
    # Matches variations of "owo", preceded or followed by whitespace, case insensitive
    reg = /^\s*[ou][wmn][ou]\s*$/i

    # Break if regex doesn't match.
    if (not reg.test(msg.content)) or msg.author.bot then return no

    # Do it one out of 3 times so it doesn't get too annoying
    if (1 / 3) <= Math.random() then return no

    msg.channel?.send [
        "What's this?"
        "uwu what's this???"
        "whats this"
    ].choose()

    # Message doesn't call Haruka, exit prematurely
    yes

module.exports = {
    name: "Owo"
    handler: handler
}
