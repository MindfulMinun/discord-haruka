# Haruka

Haruka, your useless Discord bot. [Add Haruka][add].

- [Commands](#commands)
- [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)

## Commands
As of `v1.3.2`, Haruka has 17 functions:

- [`-h 8ball`][8ball]: Answers any yes or no question.
- [`-h about`][about]: General stuff about Haruka.
- [`-h aesthetic`][ae]: Makes your text more ａｅｓｔｈｅｔｉｃ.
- [`-h emote`][emote]: Manages server emotes
- [`-h github`][github]: Retrieve information about a GitHub repository.
- [`-h help`][help]: Returns a list of all the commands, much like this one.
- [`-h invite`][invite]: Replies with a URL to invite Haruka to other servers.
- [`-h kanji`][kanji]: Retrieve information about a Kanji character.
- [`-h now`][now]: Returns the current time in UTC
- [`-h pfp`][pfp]: Return a user’s profile image as a URL.
- [`-h ping`][ping]: Replies “Pong!”
- [`-h pkmn`][pkmn]: Gets information about a Pokémon.
- [`-h purge`][purge]: Deletes messages in bulk.
- [`-h restart`][restart]: Restarts Haruka.
- [`-h say`][say]: Replies with whatever you tell it to.
- [`-h someone`][someone]: Mentions a user chosen at random.
- [`-h version`][version]: Prints out version information about Haruka

## Installation

Although Haruka _can_ be installed via `npm i discord-haruka`, it’s not recommended, as Haruka isn’t a module. Instead, go to the [GitHub repo][repo] and get a copy of [Haruka’s latest release][releases]. In the root directory, open the file called `example-config.json`, looking something like this:

```json
{
  "version": "1.3.2",
  "dev": true,
  "token": "<https://discordapp.com/developers/applications/me>",
  "client_id": "<https://discordapp.com/developers/applications/me>",
  "kanji-alive-api-key": "<https://market.mashape.com/KanjiAlive/learn-to-read-and-write-japanese-kanji>",
  "ops": [
    "<userID>"
  ]
}
```

Replace each thing in `<angle brackets>` with its respective value. Both `token` and `client_id` can be found in [your Discord apps][discord-my-apps]. `kanji-alive-api-key` is your `X-Mashape-Key` header used for [KanjiAlive][kanjialive], the API used to get Kanji data. If you don't wish to use the Kanji function, rename `dist/functions/kanji.js` to `dist/functions/_kanji.js`. `ops` is an array of user IDs; a user ID represents a user on Discord, and these are used to determine who can run the `-h restart` command, which kills the Haruka process.

Finally, rename `example-config.json` to `config.json`, run `npm install` to install Haruka’s dependencies, and run her locally by using `npm start`.

## Contributing
First of all, [get to know how Haruka works][haruka-teardown]. Haruka is made of several component parts, and understanding how they work will ease development. Install Haruka as [mentioned above](#installation), create a fork with your changes, and issue a Pull Request. Haruka’s written in CoffeeScript, you can build her by running `coffee -o dist/ -cw src/` in the root directory with CoffeeScript installed. It’s also recommended you have a CoffeeScript linter installed.

## License

[MIT License][license]

<!-- Reference links -->
[kanjialive]: https://market.mashape.com/KanjiAlive/learn-to-read-and-write-japanese-kanji "KanjiAlive API Documentation"
[repo]: https://github.com/MindfulMinun/discord-haruka "MindfulMinun/discord-haruka"
[releases]: https://github.com/MindfulMinun/discord-haruka/releases "Releases · MindfulMinun/discord-haruka"
[discord-my-apps]: https://discordapp.com/developers/applications/me "Discord - My Apps"
[license]: https://github.com/MindfulMinun/discord-haruka/blob/master/LICENSE "discord-haruka/LICENSE"
[add]: https://discordapp.com/oauth2/authorize?client_id=458130019554820127&scope=bot&permissions=125966 "Add Haruka to your Discord server."
[haruka-teardown]: https://benjic.xyz/2018-07-30/haruka-teardown/ "Haruka Teardown"

<!-- Function links -->
[8ball]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/8ball.coffee
[about]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/about.coffee
[ae]:      https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/aesthetic.coffee
[emote]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/emote.coffee
[github]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/github.coffee
[help]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/help.coffee
[invite]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/invite.coffee
[kanji]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/kanji.coffee
[now]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/now.coffee
[pfp]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pfp.coffee
[ping]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/ping.coffee
[pkmn]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pkmn.coffee
[purge]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/purge.coffee
[restart]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/restart.coffee
[say]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/say.coffee
[someone]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/someone.coffee
[version]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/version.coffee
