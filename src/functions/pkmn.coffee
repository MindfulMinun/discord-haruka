#! ========================================
#! Pokémon

Discord = require 'discord.js'
request = require 'request'

r = (options) ->
    new Promise (resolve, reject) ->
        request options, (err, response, body) ->
            shouldResolve = [
                not err,
                200 <= response?.statusCode < 400
                not JSON.parse(body).error
            ].every((v) -> v) is yes

            if shouldResolve
                resolve JSON.parse body
            else
                reject JSON.parse body

#! String utils
capitalize = (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)
dasherize = (str) -> str.toLowerCase().replace(/[^A-Za-z0-9\s]/g, '').replace(/\s+/g, '-')
undasherize = (str) -> str.split('-').map((s) -> capitalize s).join(' ')
#! ToDexNumber
toDexNumber = (n) -> '#' + n.toString().padStart 3, '0'

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

        P.category = species.genera
            .filter((genus) -> genus.language.name is "en")
            .choose()
            .genus
        return PPromise
    .then (p) ->
        pkmn = p
        P.abilities = pkmn.abilities.map((a) -> undasherize a.ability.name).join(', ')
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
        P.stats = P.stats.sort((a, b) -> a.pos - b.pos).map((x) -> x.txt).join('; ')
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
        console.log err
        if err.detail is "Not found."
            msg.reply [
                "That Pokémon doesn’t seem to exist in my Pokédex,
                    did you type its name correctly?"
                "I couldn’t find that Pokémon in my Pokédex.
                    Try asking a Professor instead?"
            ].choose()
        else
            msg.reply [
                "An error occurred while fetching the Pokémon.
                    Sorry about that."
                "An exception was thrown while fetching the Pokémon."
            ].choose()

###
_handler = (msg, match) ->
    #! Define a few constants
    SPECIES_URL = "https://pokeapi.co/api/v2/pokemon-species/"
    PKMN_URL    = "https://pokeapi.co/api/v2/pokemon/"
    species = null
    pkmn    = null
    P       = {}

    pokeRequest = match.input.tokenize()[1]

    try
        if not pokeRequest
            return msg.reply [
                "Use `-h pkmn` followed by the Pokémon you want me to look up."
                "I can look for Pokémon in my Pokédex if you use `-h pkmn `
                    followed by a Pokémon's name or National Dex number."
                "You’re missing a few arguments. Try `-h help pkmn` if
                    you forgot this command’s syntax."
            ].choose()

        species = JSON.parse(
            await fetch SPECIES_URL + pokeRequest.toLowerCase() + "/"
        )
        #! Postpone JSON.parse pkmn until it's needed
        pkmn = fetch PKMN_URL + species.id + "/"

        #! Break if Pokémon not found.
        if species.detail is "Not found."
            return msg.reply [
                "My database is telling me that that Pokémon doesn’t exist?"
                "Error 404: Pokémon Not Found"
                "I couldn’t find that Pokémon in my Pokédex.
                    Try asking a Professor instead?"
            ].choose()

        P.name = (do ->
            for name in species.names
                if name.language.name is "en"
                    return name.name
        )
        P.dexNumber = toDexNumber species.id

        #! Let the user know we're loading stuff
        msg.reply [
            "Information about #{P.name}, coming right up!"
            "Looking through my Pokédex for #{P.name}..."
            "Looking up #{P.name}, hold tight..."
            "Getting info on #{P.name}..."
            "Looking up #{P.name}’s favorite berries..."
        ].choose()

        P.description = species.flavor_text_entries
            .filter((f) -> f.language.name is "en")
            .first()
            .flavor_text
            .replace(/\n/g, ' ')

        P.category = species.genera
            .filter((genus) -> genus.language.name is "en")
            .first()
            .genus

        #! Postpone JSON.parse pkmn until it's needed
        pkmn = JSON.parse await pkmn
        P.types = pkmn.types.map((t) -> capitalize t.type.name)

        #! Create the embed object
        embed = new Discord.RichEmbed()
            .setColor '#448aff'
            .setURL "https://www.smogon.com/dex/sm/pokemon/#{
                if P.name is "Meowstic" then "meowstic-m" else species.name
            }/"
            .setThumbnail pkmn.sprites.front_default
            .setTitle "#{capitalize P.name} — #{P.dexNumber}"
            .setDescription P.description
            .addField "National Dex \#", P.dexNumber, yes
            .addField "Typing", P.types.join("/"), yes
            .addField "Category", P.category, yes
        msg.channel.send embed
    catch err
        console.log "========================================"
        console.log err
        console.log {species: species, pkmn: pkmn, P: P}
        msg.reply [
            "Uhh, an error occurred. Did you type everything in properly?"
            "An error occurred, make sure you're using the right command."
            "Something happened, an error occurred.
                Check your command and try again."
        # ].choose()
###

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
