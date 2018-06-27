# Haruka

Haruka, your useless Discord bot. [Add Haruka][add]

- [Commands](#commands)
- [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)


## Commands
As of `v1.2.0`, Haruka has 8 functions:

- [`-h 8ball`][8ball]: Answers any yes or no question.
- [`-h about`][about]: General stuff about Haruka.
- [`-h github`][github]: Retrieve information about a GitHub repository.
- [`-h help`][help]: Returns a list of all the commands, much like this one.
- [`-h invite`][invite]: Replies with a URL to invite Haruka to other servers.
- [`-h kanji`][kanji]: Retrieve information about a Kanji character.
- [`-h pfp`][pfp]: Return a user’s profile image as a URL.
- [`-h ping`][ping]: Replies “Pong!”
- [`-h pkmn`][pkmn]: Gets information about a Pokémon.
- [`-h say`][say]: Replies with whatever you tell it to.

## Installation

Although Haruka _can_ be installed via `npm i discord-haruka`, it’s not recommended, as Haruka isn’t a module. Instead, go to the [GitHub repo][repo] and get a copy of [Haruka’s latest release][releases]. In the root directory, open the file called `example-config.json`, looking something like this:

```json
{
  "token": "https://discordapp.com/developers/applications/me",
  "client_id": "https://discordapp.com/developers/applications/me",
  "kanji-alive-api-key": "https://market.mashape.com/KanjiAlive/learn-to-read-and-write-japanese-kanji"
}
```

Replace each URL with its respective value. Both `token` and `client_id` can be found in [your Discord apps][discord-my-apps]. `kanji-alive-api-key` is your `X-Mashape-Key` header used for [KanjiAlive][kanjialive], the API used to get Kanji data. If you don't wish to use the Kanji function, rename `dist/functions/kanji.js` to `dist/functions/_kanji.js`.

Finally, rename `example-config.json` to `config.json`, run `npm install` to install Haruka’s dependencies, and run her locally by using `npm start`.

## Contributing
Install Haruka as [mentioned above](#installation): create a fork with your changes, and issue a Pull Request. Haruka’s written in CoffeeScript, you can build her by running `coffee -o dist/ -cw src/` in the Terminal with CoffeeScript installed. It's also recommended you have a CoffeeScript linter installed.

## License

[MIT License][license]



<!-- Reference links -->
[kanjialive]: https://market.mashape.com/KanjiAlive/learn-to-read-and-write-japanese-kanji "KanjiAlive API Documentation"
[repo]: https://github.com/MindfulMinun/discord-haruka "MindfulMinun/discord-haruka"
[releases]: https://github.com/MindfulMinun/discord-haruka/releases "Releases · MindfulMinun/discord-haruka"
[discord-my-apps]: https://discordapp.com/developers/applications/me "Discord - My Apps"
[license]: https://github.com/MindfulMinun/discord-haruka/blob/master/LICENSE "discord-haruka/LICENSE"
[add]: https://discordapp.com/oauth2/authorize?client_id=458130019554820127&scope=bot&permissions=125966 "Add Haruka to your Discord server."

<!-- Function links -->
[8ball]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/8ball.coffee
[about]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/about.coffee
[github]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/github.coffee
[help]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/help.coffee
[invite]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/invite.coffee
[kanji]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/kanji.coffee
[pfp]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pfp.coffee
[ping]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/ping.coffee
[pkmn]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pkmn.coffee
[say]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/say.coffee
