#! ========================================
#! Play
# FIXME: Make code more readable / easier to understand.

Discord = require "discord.js"
ytdl    = require "ytdl-core"

Queue = {}

###*
 * Queue will look something like this:
 * Queue = {
 *     "guildId": {
 *         playing: Boolean
 *         queue: [url, url, url, ...]
 *     }
 * }
###

PlayNextInQueue = (msg) ->
    q = Queue[msg.guild.id] or=
        playing: no
        queue: []
    url = q.queue.shift()
    vc = msg.member?.voiceChannel

    if not url then return false

    if not q.playing
        vc.join()
            .then (connection) ->
                ytdl.getInfo(url)
                    .then (info) ->
                        msg.channel.send "
                            Now playing:
                            **#{info.title}** (#{info.length_seconds}sec)
                        "
                #! Play stream
                stream = ytdl(url, filter: 'audioonly')
                dispatcher = connection.playStream(stream)
                q.playing = yes
                dispatcher.on 'end', ->
                    q.playing = no
                    vc.leave()
                    PlayNextInQueue(msg) or msg.channel.send("Ended.")
            .catch (err) ->
                console.log err
                vc.leave()
                msg.channel.send [
                    "An unexpected error occurred. Darn."
                    "Oof, an error occurred."
                ].choose()
    else
        return false


AddToQueue = (url, msg) ->
    q = Queue[msg.guild.id] or=
        playing: no
        queue: []
    q.queue.push(url)

    ytdl.getInfo(url)
        .then (info) ->
            msg.channel.send "
                Added to queue:
                **#{info.title}** (#{info.length_seconds}sec)
            "
        .catch (err) ->
            msg.channel.send "
                An error occurred while adding video to queue.
                Did you enter a YouTube video or ID?
            "

    PlayNextInQueue(msg) if not q.playing

handler = (msg, match, Haruka) ->
    vc = msg.member?.voiceChannel
    url = msg.content.tokenize()[1]?.tokenize()[1]

    if not vc then return msg.reply [
        "Please join a voice channel first."
        "Join a voice channel before running this command."
    ].choose()

    if not url then return msg.reply [
        "Please specify a YouTube video URL or ID."
    ].choose()

    AddToQueue(url, msg, vc)

module.exports = {
    name: "Play"
    regex: /^(play|yt|youtube)(\s+|$)/i
    handler: handler
    help:
        short: "-h play <...>  ::
            Plays a YouTube video in a voice channel."
        long: """
            ```asciidoc
            === Help for Play ===
            *Aliases*: play, yt, youtube
            -h fn <URL or Video ID> :: Plays a given YouTube video \
            in a voice channel.
            ```
        """
}
