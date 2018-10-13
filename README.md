[API Docs][docs] | [GitHub][repo] | [npm][npm] | [Teardown][haruka-teardown]

# Haruka

Haruka, your useless Discord bot. [Add Haruka][add].

- [Commands](#commands)
- [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)

## Commands
As of `v2.0.0`, Haruka has 21 functions:

- [`-h 8ball`][f-8ball]: Answers any yes or no question.
- [`-h about`][f-about]: General stuff about Haruka.
- [`-h aesthetic`][f-ae]: Makes your text more ａｅｓｔｈｅｔｉｃ.
- [`-h anime`][f-anime]: Looks up information for an anime, you weeb.
- [`-h emote`][f-emote]: Manages server emotes
- [`-h github`][f-github]: Retrieve information about a GitHub repository.
- [`-h health`][f-health]: Tips to improve your bodily health.
- [`-h help`][f-help]: Returns a list of all the commands, much like this one.
- [`-h invite`][f-invite]: Replies with a URL to invite Haruka to other servers.
- [`-h kanji`][f-kanji]: Retrieve information about a Kanji character.
- [`-h kick`][f-kick]: Kicks all of the mentioned users.
- [`-h now`][f-now]: Returns the current time in UTC
- [`-h pfp`][f-pfp]: Return a user’s profile image as a URL.
- [`-h ping`][f-ping]: Replies “Pong!”
- [`-h pkmn`][f-pkmn]: Gets information about a Pokémon.
- [`-h purge`][f-purge]: Deletes messages in bulk.
- [`-h restart`][f-restart]: Restarts Haruka.
- [`-h reverse`][f-reverse]: Reverses some text.
- [`-h say`][f-say]: Replies with whatever you tell it to.
- [`-h someone`][f-someone]: Mentions a user chosen at random.
- [`-h version`][f-version]: Prints out technical information about Haruka.
- [`-h xkcd`][f-xkcd]: Fetches xkcd comics.

## Installation

Although Haruka _can_ be installed via `npm i discord-haruka`, it’s not recommended, as Haruka isn’t a module. Instead, go to the [GitHub repo][repo] and get a copy of [Haruka’s latest release][releases]. In the root directory, open the file called `example-config.json`. The most important bits are as follows.:

```json
{
  "version": "<Version number>",
  "dev": false,
  "token": "<https://discordapp.com/developers/applications/me>",
  "kanji-alive-api-key": "<https://market.mashape.com/KanjiAlive/learn-to-read-and-write-japanese-kanji>",
  "ops": [
    "<userID>"
  ]
}
```

Replace each thing in `<angle brackets>` with its respective value. `token` is your bot’s login token, which can be found in [your Discord apps][discord-my-apps]. `kanji-alive-api-key` is your `X-Mashape-Key` header used for [KanjiAlive][kanjialive], the API used to get Kanji data. If you don't wish to use the Kanji function, rename `dist/functions/kanji.js` to `dist/functions/_kanji.js`. `ops` is an array of user IDs; a user ID represents a user on Discord, and these are used to determine who can run the `-h restart` command, which kills the Haruka process.

Finally, rename `example-config.json` to `config.json`, run `npm install` to install Haruka’s dependencies, and run her locally by using `npm start`.

## Contributing
First of all, [get to know how Haruka works][haruka-teardown]. Haruka is made of several component parts, and understanding how they work will ease development. Install Haruka as [mentioned above](#installation), create a fork with your changes, and issue a Pull Request. Haruka’s written in CoffeeScript, you can build her by running `coffee -o dist/ -cw src/` in the root directory with CoffeeScript installed. It’s also recommended you have a CoffeeScript linter installed.

## License

[MIT License][license]

<!-- Reference links -->
[docs]: https://haruka.benjic.xyz/ "Haruka API Documentation"
[repo]: https://github.com/MindfulMinun/discord-haruka "MindfulMinun/discord-haruka · GitHub"
[haruka-teardown]: https://benjic.xyz/2018-07-30/haruka-teardown/ "Haruka Teardown"
[npm]: https://www.npmjs.com/package/discord-haruka "discord-haruka · npm"
[kanjialive]: https://market.mashape.com/KanjiAlive/learn-to-read-and-write-japanese-kanji "KanjiAlive API Documentation"
[releases]: https://github.com/MindfulMinun/discord-haruka/releases "Releases · MindfulMinun/discord-haruka"
[discord-my-apps]: https://discordapp.com/developers/applications/me "Discord - My Apps"
[license]: https://github.com/MindfulMinun/discord-haruka/blob/master/LICENSE "discord-haruka/LICENSE"
[add]: https://discordapp.com/oauth2/authorize?client_id=458130019554820127&scope=bot&permissions=125966 "Add Haruka to your Discord server."

<!-- Function links -->
[f-8ball]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/8ball.coffee
[f-about]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/about.coffee
[f-ae]:      https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/aesthetic.coffee
[f-anime]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/anime.coffee
[f-emote]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/emote.coffee
[f-github]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/github.coffee
[f-health]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/health.coffee
[f-help]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/help.coffee
[f-invite]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/invite.coffee
[f-kanji]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/kanji.coffee
[f-kick]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/kick.coffee
[f-now]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/now.coffee
[f-pfp]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pfp.coffee
[f-ping]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/ping.coffee
[f-pkmn]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pkmn.coffee
[f-purge]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/purge.coffee
[f-restart]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/restart.coffee
[f-reverse]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/reverse.coffee
[f-say]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/say.coffee
[f-someone]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/someone.coffee
[f-version]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/version.coffee
[f-xkcd]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/xkcd.coffee
