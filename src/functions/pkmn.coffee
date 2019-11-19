#! ========================================
#! Pokémon

Discord = require 'discord.js'
request = require 'request'

r = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            if (
                (not err) and
                (200 <= response?.statusCode <= 400) and
                (not JSON.parse(body).error)
            )
                resolve JSON.parse body
            else
                # Don't do JSON.body, pokeapi likes to return
                # HTML-formatted 404s instead of error messages.
                # This is the reason Haruka was crashing.
                reject [err, response, body]

#! String utils
capitalize = (txt) ->
    txt.charAt(0).toUpperCase() + txt.substr(1)
dasherize = (str) ->
    str.toLowerCase()
        .replace(/[^A-Za-z0-9\s]/g, '')
        .replace(/\s+/g, '-')
undasherize = (str) ->
    str.split('-').map((s) -> capitalize s).join(' ')
toDexNumber = (n) ->
    '#' + n.toString().padStart 3, '0'

#! ========================================
#! Message handler
handler = (msg, match, Haruka) ->
    pokeRequest = dasherize match.input.tokenize()[1]
    if not pokeRequest then return msg.reply [
        "Use `-h pkmn` followed by the Pokémon you want me to look up."
        "I can look for Pokémon in my Pokédex if you use `-h pkmn`
            followed by a Pokémon's name or its National Dex number."
        "You’re missing an argument. Try `-h help pkmn` if
            you forgot this command’s syntax."
    ].choose()
    [P, species, pkmn] = [{}, null, null]
    pokeRequest = pokeRequest.replace(/^\s*0/g, '')

    #! Fetch pkmn
    r "https://pokeapi.co/api/v2/pokemon-species/#{pokeRequest}/"
    .then (s) ->
        species = s
        PPromise = r "https://pokeapi.co/api/v2/pokemon/#{species.id}/"
        P.name = species.names
            .filter((n) -> n.language.name is "en")
            .choose()
            .name
        P.dexNumber = toDexNumber species.id
        P.description = species.flavor_text_entries
            .filter((f) -> f.language.name is "en")
            .choose()
            .flavor_text
            .replace(/\s+/g, ' ')
            # Replace multiple occurrences of whitespace with just one space.
        P.category = species.genera
            .filter((genus) -> genus.language.name is "en")
            .choose()
            .genus
        return PPromise
    .then (p) ->
        pkmn = p
        P.abilities = pkmn.abilities
            .map((a) -> undasherize a.ability.name)
            .join(', ')
        P.sprite = pkmn.sprites.front_default
        P.types = pkmn.types.map((t) -> capitalize t.type.name)
        P.movepool = pkmn.moves.length + " moves"
        P.stats = pkmn.stats.map (s) ->
            switch (s.stat.name)
                when "hp" then {pos: 0, txt: "HP: #{s.base_stat}"}
                when "attack" then {pos: 1, txt: "Atk: #{s.base_stat}"}
                when "defense" then {pos: 2, txt: "Def: #{s.base_stat}"}
                when "special-attack" then {pos: 3, txt: "SpA: #{s.base_stat}"}
                when "special-defense" then {pos: 4, txt: "SpD: #{s.base_stat}"}
                when "speed" then {pos: 5, txt: "Spd: #{s.base_stat}"}
        P.stats = P.stats
            .sort((a, b) -> a.pos - b.pos)
            .map((x) -> x.txt).join('; ')
    .then ->
        #! Create the embed object
        embed = new Discord.RichEmbed()
            .setColor '#448aff'
            .setURL "https://www.smogon.com/dex/sm/pokemon/#{P.name}/"
            .setThumbnail P.sprite
            .setTitle "#{capitalize P.name} — #{P.dexNumber}"
            .setDescription P.description
            .addField "National Dex \#", P.dexNumber, yes
            .addField "Typing", P.types.join("/"), yes
            .addField "Category", P.category, yes
            .addField "Movepool", P.movepool, yes
            .addField "Abilities", P.abilities
            .addField "Base stats", P.stats
        msg.channel.send embed
    .catch (err) ->
        [err, response, body] = err
        try
            body = JSON.parse(body)
        if not (200 <= response?.statusCode <= 400)
            msg.reply [
                "Sorry, but I couldn't find that Pokémon.
                    Did you spell its name right?"
                "I’m not finding that Pokémon in my Pokédex.
                    Perhaps try entering a Pokédex number instead?"
            ].choose()
        else
            msg.reply [
                "An unexpected error occurred while fetching the Pokémon.
                    This shouldn’t typically happen,
                    try again in a few seconds."
                "A wild, unrecoverable error occurred!
                    Errors like this shouldn’t typically happen,
                    try again in a few seconds."
            ].choose()

module.exports = {
    name: "Pokémon"
    regex: /^(pkmn|pokemon|pokémon|poke|poké)(\s+|$)/i
    handler: handler
    #! coffeelint: disable=max_line_length
    help:
        short: "-h pkmn <...>  ::
            Get information regarding a Pokémon (See -h help pkmn)"
        long: """
            ```asciidoc
            === Help for Pokémon ===
            *Aliases*: pkmn, pokemon, pokémon, poke, poké
            -h pkmn <nameOrId> :: Given a Pokémon’s name or National Pokédex Number,
                                  this command returns information on a specific Pokémon.
            ```
        """ #! coffeelint: enable=max_line_length
}
