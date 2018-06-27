#! ========================================
#! Special name

handler = (msg, Haruka) ->
    if not msg.content.startsWith("i'm") then return no
    msg.channel.send "Hi, #{msg.content.tokenize()[1]}, I’m dad."

module.exports = {
    name: "Special"
    handler: handler
}
