#! ========================================
#! Special: Dad

handler = (msg, Haruka) ->

    reg = /^(?:i(?:['’]|(?:\s+a))?m)\s+/i
    # Matches "im ", "i'm ", "i’m ", and "i am "
    # Case insensitive, whitespace required.

    # Break if regex doesn't match.
    if (not reg.test(msg.content)) or msg.author.bot then return no

    # If the person's fortunate enough to get a number higher than
    # 1 / 10, they’re spared.
    if (1 / 10) <= Math.random() then return no

    #! Likewise, if they're unlucky, send the reply.
    reply = msg.content.replace reg, ''
    msg.channel?.send [
        "Hey #{reply}, I’m Haruka."
        "Hi #{reply}, I’m Haruka."
        "Hello #{reply}, I’m Haruka. Nice to meet you."
    ].choose()

module.exports = {
    name: "Dad"
    handler: handler
}
