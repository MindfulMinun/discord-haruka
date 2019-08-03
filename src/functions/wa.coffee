#! ========================================
#! WolframAlpha

r = require "#{__dirname}/../helpers/fetch"
Embed = (require 'discord.js').RichEmbed

path = [
    "http://api.wolframalpha.com/v1/query?"
    "appid=#{process.env.WA_APPID}"
    "&output=json"
    "&input="
].join ''


handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]

    if not args
        return msg.reply [
            "Please enter a search term."
            "What would you like to know about?"
        ].choose()

    msg.reply "Searching for “#{args}”...", disableEveryone: yes
        .then (reply) ->
            r path + encodeURIComponent args
            .then (json) ->
                result = json.queryresult
                if (not result) or (result.success is no)
                    return msg.reply [
                        "An error occurred while processing the input."
                    ].choose()

                embed = new Embed()
                embed.setFooter("Powered by WolframAlpha")

                embed.setURL "https://www.wolframalpha.com/input/?i=#{
                    encodeURIComponent args
                }"
                embed.setTitle "Results for “#{args}”"

                if /^Input/.test result.pods[0].title
                    input = result.pods.shift()
                    embed.setTitle input.title
                    textPods = input.subpods
                        .filter((x) -> x.plaintext.trim().length)

                    if textPods.length
                        embed.setDescription(
                            textPods
                                .map((x) -> x.plaintext)
                                .join '\n'
                        )

                for pod in result.pods[..10]
                    textPods = pod.subpods
                        .map (x) ->
                            # if x.img and x.img.alt
                            # alt = x.img.alt
                            #       .replace(/[*_]/g, '\\$&') or "See image"
                            # return "[#{alt}](#{x.img.src})"
                            if x.plaintext
                                return x.plaintext.replace(/[\\*_]/g, '\\$&')
                        .filter (x) -> x?
                    if textPods.length
                        embed.addField(
                            pod.title,
                            textPods.join '\n\n'
                        )

                reply.delete()
                msg.reply "Results for “#{args}”:", embed


        .catch (err) ->
            console.log err
            msg.reply [
                "An error occurred. Whoops."
                "Something happened while processing the input."
            ].choose()

module.exports = {
    name: "WolframAlpha"
    regex: /^(wa|wolfram|wolframalpha)(\s+|$)/i
    handler: handler
    help:
        short: "-h wa <query>  ::
            Ask anything with WolframAlpha."
        long: """
            ```asciidoc
            === Help for WolframAlpha ===
            *Aliases*: wa, wolfram, wolframalpha
            -h wa <query> :: Computes stuff with WolframAlpha
            ```
        """
}
