#! ========================================
#! Pokémon

Discord = require 'discord.js'

#! Helper Functions
#! Fetch
fetch = (url) ->
    new Promise (resolve, reject) ->
        http  = require 'http'
        https = require 'https'

        client = http
        if url.toString().indexOf("https") is 0 then client = https

        client.get url, (r) ->
            data = ''

            #! A chunk of data has been recieved
            r.on 'data', (chunk) -> data += chunk
            #! Whole response recieved, print result
            r.on 'end', -> resolve data
        .on 'error', (err) ->
            reject err
#! Capitalize
capitalize = (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1)
#! ToDexNumber
toDexNumber = (n) -> '#' + n.toString().padStart 3, '0'

#! ========================================
#! Message handler
handler = (msg, match) ->
    #! Define a few constants
    SPECIES_URL = "https://pokeapi.co/api/v2/pokemon-species/"
    PKMN_URL    = "https://pokeapi.co/api/v2/pokemon/"
    species = null
    pkmn    = null
    P       = {}

    try
        if not match.last()
            return msg.reply [
                "Use `-h pkmn ` followed by the Pokémon you want me to look up."
                "I can look for Pokémon in my Pokédex if you use `-h pkmn `
                    followed by a Pokémon's name or National Dex number."
                "You’re missing a few arguments. Try `-h help pkmn` if
                    you forgot this command’s syntax."
            ].choose()

        species = JSON.parse(
            await fetch SPECIES_URL + match.last().toLowerCase() + "/"
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

        P.description = do ->
            for f in species.flavor_text_entries
                if f.language.name is "en"
                    return f.flavor_text.replace /\n/g, ' '

        P.category = do ->
            for genus in species.genera
                if genus.language.name is "en"
                    return genus.genus

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
            .addField "National Dex \#", P.dexNumber
            .addField "Typing", P.types.join "/"
            .addField "Category", P.category
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
        ].choose()

module.exports = {
    name: "Pokémon"
    regex: /^(?:(?:poke(?:mon)?)|(?:pkmn))\s*(\S[\s\S]*)?/i
    handler: handler
    #! coffeelint: disable=max_line_length
    help: """
        ```asciidoc
        === Help for Pokémon ===
        *Aliases*: pkmn, pokemon, poke
        -h pkmn <nameOrId> :: Given a Pokémon’s name or National Pokédex Number,
                              this command returns information on a specific Pokémon.
        ```
    """ #! coffeelint: enable=max_line_length
}
