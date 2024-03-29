[API Docs][docs] | [GitHub][repo] | [npm][npm] | [Teardown][haruka-teardown]

# Haruka

Haruka, your useless Discord bot. [Add Haruka][add].

- [Commands](#commands)
- [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)

## Commands
Haruka has 25 functions:

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
- [`-h manga`][f-manga]: Looks up information for a manga, you weeb.
- [`-h now`][f-now]: Returns the current time in UTC
- [`-h pfp`][f-pfp]: Return a user’s profile image as a URL.
- [`-h ping`][f-ping]: Replies “Pong!”
- [`-h pkmn`][f-pkmn]: Gets information about a Pokémon.
- [`-h purge`][f-purge]: Deletes messages in bulk.
- [`-h restart`][f-restart]: Restarts Haruka.
- [`-h reverse`][f-reverse]: Reverses some text.
- [`-h say`][f-say]: Replies with whatever you tell it to.
- [`-h smash`][f-smash]: Looks up information on any Smash Ultimate fighter.
- [`-h someone`][f-someone]: Mentions a user chosen at random.
- [`-h version`][f-version]: Prints out technical information about Haruka.
- [`-h wa`][f-wa]: Compute anything with WolframAlpha.
- [`-h xkcd`][f-xkcd]: Fetches xkcd comics.

## Installation

Although Haruka _can_ be installed via `npm i discord-haruka`, it’s not recommended, as Haruka isn’t a module. Instead, go to the [GitHub repo][repo] and get a copy of [Haruka’s latest release][releases]. In the root directory, open the file called `.env.ex`, and place your keys in there.

```env
DISCORD_TOKEN=
KANJI_ALIVE_KEY=
WA_APPID=
HARUKA_OPS=
```

Place your *super sensitive* keys in here. Be mindful as to not add spaces around the equal sign. `DISCORD_TOKEN` is your bot’s login token which can be found in [the Discord Developer portal][discord-my-apps]. The second key, `KANJI_ALIVE_KEY`, is your `X-Mashape-Key` used for [KanjiAlive][kanjialive], the API used to retrieve Kanji data. If you don't wish to use the Kanji function, rename `src/functions/kanji.coffee` to `src/functions/_kanji.coffee` and rerun the build command. In a similar fashion, the `WA_APPID` key is Haruka's WolframAlpha AppID, which can be found [here][wolfram-dev-portal]. You can disable this function similarly to disabling the Kanji function.

The `HARUKA_OPS` key is a comma-separated list of IDs of users who can run the `-h halt` command. Add your User ID to the list. If adding multiple people, please separate them with commas WITHOUT any surrounding spaces. The `HARUKA_LOG_GUILD_ID` and `HARUKA_LOG_CHANNEL_ID` are for collecting function usage statistics. Haruka will send *basic* information about the command called in this guild and channel. If you do not wish to gather usage statistics, you may omit these fields.

Finally, rename `.env.ex` to simply `.env`. Run `npm install` to install Haruka’s dependencies, and run her locally by using `npm start`.

## Contributing
First of all, [get to know how Haruka works][haruka-teardown]. Haruka is made of several component parts, and understanding how they work will ease development. Install Haruka as [mentioned above](#installation), create a fork with your changes, and issue a Pull Request. Haruka’s written in CoffeeScript, you can build her by running `npm build` or `npm watch` in the root directory with CoffeeScript installed (devDependency). It’s also recommended you have a CoffeeScript linter installed.

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
[wolfram-dev-portal]: https://developer.wolframalpha.com/portal/myapps/index.html "Wolfram|Alpha Developer Portal: My Applications"

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
[f-manga]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/manga.coffee
[f-now]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/now.coffee
[f-pfp]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pfp.coffee
[f-ping]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/ping.coffee
[f-pkmn]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pkmn.coffee
[f-purge]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/purge.coffee
[f-restart]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/restart.coffee
[f-reverse]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/reverse.coffee
[f-say]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/say.coffee
[f-smash]:     https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/smash.coffee
[f-someone]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/someone.coffee
[f-version]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/version.coffee
[f-wa]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/wa.coffee
[f-xkcd]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/xkcd.coffee
