#! ========================================
#! Smash

Discord = require 'discord.js'
r = require "#{__dirname}/../helpers/fetch"
fuzzysort = require 'fuzzysort'

# Map series slugs to series names
seriesMap = {
    "mario": "Super Mario"
    "donkeykong": "Donkey Kong"
    "zelda": "Zelda"
    "metroid": "Metroid"
    "yoshi": "Yoshi"
    "kirby": "Kirby"
    "starfox": "Star Fox"
    "pokemon": "Pokémon"
    "mother": "EarthBound"
    "f-zero": "F-Zero"
    "iceclimber": "Ice Climber"
    "fireemblem": "Fire Emblem"
    "gamewatch": "Game & Watch"
    "palutena": "Kid Icarus"
    "wario": "WarioWare"
    "metalgear": "Metal Gear"
    "sonic": "Sonic"
    "pikmin": "Pikmin"
    "famicomrobot": "R.O.B."
    "doubutsu": "Animal Crossing"
    "rockman": "Mega Man"
    "wii_fit": "Wii Fit"
    "punch_out": "Punch-Out!!"
    "mii": "Mii"
    "pacman": "PAC-MAN"
    "xenoblade": "Xenoblade Chronicles"
    "duckhunt": "Duck Hunt"
    "streetfighter": "Street Fighter"
    "finalfantasy": "Final Fantasy"
    "bayonetta": "Bayonetta"
    "splatoon": "Splatoon"
    "dracula": "Castlevania"
    "persona": "Persona"
    "dragonquest": "Dragon Quest"
    "banjo_and_kazooie": "Banjo-Kazooie"
    "garou": "Fatal Fury"
}

# Map fighters to their names
fNameMap = [
    "Mario"
    "Donkey Kong"
    "Link"
    "Samus"
    "Dark Samus"
    "Yoshi"
    "Kirby"
    "Fox"
    "Pikachu"
    "Luigi"
    "Ness"
    "Captain Falcon"
    "Jigglypuff"
    "Peach"
    "Daisy"
    "Bowser"
    "Ice Climbers"
    "Sheik"
    "Zelda"
    "Dr. Mario"
    "Pichu"
    "Falco"
    "Marth"
    "Lucina"
    "Young Link"
    "Ganondorf"
    "Mewtwo"
    "Roy"
    "Chrom"
    "Mr. Game & Watch"
    "Meta Knight"
    "Pit"
    "Dark Pit"
    "Zero Suit Samus"
    "Wario"
    "Snake"
    "Ike"
    "Pokémon Trainer"
    "Diddy Kong"
    "Lucas"
    "Sonic"
    "King Dedede"
    "Olimar"
    "Lucario"
    "R.O.B."
    "Toon Link"
    "Wolf"
    "Villager"
    "Mega Man"
    "Wii Fit Trainer"
    "Rosalina & Luma"
    "Little Mac"
    "Greninja"
    "Mii Fighter"
    "Palutena"
    "PAC-MAN"
    "Robin"
    "Shulk"
    "Bowser Jr."
    "Duck Hunt"
    "Ryu"
    "Ken"
    "Cloud"
    "Corrin"
    "Bayonetta"
    "Inkling"
    "Ridley"
    "Simon"
    "Richter"
    "King K. Rool"
    "Isabelle"
    "Incineroar"
    "Piranha Plant"
    "Joker"
    "Hero"
    "Banjo & Kazooie"
    "Terry"
]

root = 'https://www.smashbros.com/assets_v2'
frameDataURL = 'https://api.kuroganehammer.com/api/characters/?game=ultimate'
fighterPath = root + '/data/fighter.json'


handler = (msg, match, Haruka) ->
    args = match.input.tokenize()[1]

    if not args
        return msg.reply [
            "You didn’t enter a search term, so I couldn’t
                search for a fighter."
            "You need to enter a search term to search a fighter."
            "Provide a search term when using this command. :)"
        ].choose()

    fdata = r(frameDataURL)
    .then (json) -> (json.map (c) -> {
        name: c.DisplayName
        url: c.FullUrl
    }).reduce ((acc, v, i, arr) ->
        acc[v.name] = v.url
        return acc
    ), {}

    r fighterPath
    .then (fighters) ->
        fighters = fighters.fighters

        fighters.map((f, i) ->
            f._name = fNameMap[i]
        )

        # "I'm feeling lucky" style search
        lucky = fuzzysort.go(args, fighters, {
            keys: [
                'displayNum'
                '_name'
                'url'
                'displayNameEn'
                'displayNameEnSecondary'
            ]
        })?[0]?.obj

        return msg.reply [
            'Sorry, but I couldn’t find that fighter.'
            'I couldn’t find that fighter, sorry.'
        ].choose() if not lucky

        # Mapped name or default to the one in the JSON.
        # Falcon, G&W, and Pkmn Trainer include an html <br> element.
        # Get rid of it.
        name = (
            lucky._name or
            lucky.displayName.en_US
                .replace(/\<\S[\s\S]*?\>/gi, '')
                .replace(/\s+/g, ' ')
        )
        url = lucky.url and "
            https://www.smashbros.com/en_US/fighter/#{lucky.url}.html
        "
        imgHead = "#{root}/img/fighter/pict/#{lucky.file}.png"
        imgPanoramic = "#{root}/img/fighter/series/#{lucky.file}.png"

        title =
            # Format the name like "21e – Lucina"
            (lucky.displayNumEn or lucky.displayNum) + " — " + name

        series = ((seriesMap[lucky.series] or "`#{lucky.series}`") + " series")

        echo = do ->
            out = ''
            if lucky.dash
                out += "Yes, #{name} is "
                out += fNameMap[fighters.indexOf(lucky) - 1]
                out += '’s echo fighter.'
            else if fighters[fighters.indexOf(lucky) + 1]?.dash
                out += fNameMap[fighters.indexOf(lucky) + 1]
                out += " is #{name}’s echo fighter."
            else
                out += 'None'

            return out

        fdata = do ->
            url = (await fdata)[name]
            if url
                "[Available](#{url})"
            else
                "Not available (yet)"

        dlc = (
            if lucky.dlc
                "Yes, give Mr. Sakurai your money."
            else
                "No, comes with the game."
        )

        embed = new Discord.RichEmbed()
            .setColor lucky.color
            .setAuthor title, imgHead, (url or undefined)
            .addField 'Echo', echo, true
            .addField 'Series', series, true
            .addField 'Frame data', (await fdata), true
            .addField 'DLC', dlc, true
            .setImage imgPanoramic

        msg.channel.send embed

module.exports = {
    name: "Smash"
    regex: /^(smash|ssbu)(\s+|$)/i
    handler: handler
    help:
        short: "-h ssbu <f>    ::
            Returns some info regarding some SSBU Fighter."
        long: """
            ```asciidoc
            === Help for Smash ===
            *Aliases*: ssbu, smash
            -h ssbu <fighter> :: Retrieves information on that specific fighter.
            ```
        """
}
