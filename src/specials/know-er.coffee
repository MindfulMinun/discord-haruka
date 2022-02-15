#! ========================================
#! know-er

know_er_regex = /([\w]+[aeo]r)/gi

syllableCounter = (word) ->
    # See https://stackoverflow.com/questions/28384718/regex-understanding-syllable-counter-code
    word = word.toLowerCase()
    return 1 if word.length <= 3
    word = word.replace(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '')
    word = word.replace(/^y/, '')
    return word.match(/[aeiouy]{1,2}/g).length

handler = (msg, Haruka) ->
    matches = msg.content.match know_er_regex
    return no if not matches
    word = matches.last()
    syllables = syllableCounter(word)
    return no if syllables < 2

    msg.channel.send "#{word.capitalize()}? I hardly know 'er!"

module.exports = {
    name: "know-er"
    handler: handler
}
