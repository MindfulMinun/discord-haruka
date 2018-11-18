#! ========================================
#! who up

handler = (msg, Haruka) ->
    tests = (
        msg.guild?.id is "443094449233592325"
        # how do you do, fellow weebs?
    ) and (
        msg.author?.id is "456207047482933251"
        # sadbot#3862
    ) and (
        msg.content.startsWith 'who up'
        # "who up" and that dumb awoo meme
    )

    if not tests then return no

    msg.channel.send [
        'awoo'
        'awoooo!'
        '*achoo*'
    ].choose()


    # Message doesn't call Haruka, exit prematurely
    yes

module.exports = {
    name: "who up"
    handler: handler
}
