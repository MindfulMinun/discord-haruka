#! ========================================
#! Special

handler = (msg, Haruka) ->
    if not /^(i(['’])?m)\s/gi.test msg.content then return no
    msg.channel.send "Hi #{msg.content.tokenize()[1]}, I’m Haruka."

module.exports = {
    name: "Special"
    handler: handler
}
