# Haruka

Haruka, your useless Discord bot. [Add Haruka][add]

- [Commands](#commands)
- [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)


## Commands
As of `v1.1.0`, Haruka has 8 functions:

- [`-h 8ball`][8ball]: Answers any yes or no question.
- [`-h about`][about]: General stuff about Haruka.
- [`-h help`][help]: Returns a list of all the commands, much like this one.
- [`-h invite`][invite]: Replies with a URL to invite Haruka to other servers.
- [`-h pfp`][pfp]: Return a user’s profile image as a URL
- [`-h ping`][ping]: Replies “Pong!”
- [`-h pkmn`][pkmn]: Gets information about a Pokémon.
- [`-h say`][say]: Replies with whatever you tell it to.

## Installation

Although Haruka _can_ be installed via `npm i discord-haruka`, it’s not recommended, as Haruka isn’t a module. Instead, go to the [GitHub repo][github] and **create a fork** of Haruka. In the root directory, create a file called `config.json`, looking something like this:

```json
{
  "token": "your-token-goes-here",
  "client_id": "your-client-id-goes-here"
}
```

Both `token` and `client_id` can be found in [your Discord apps][discord-my-apps].

Finally, run `npm install` to install Haruka’s dependencies, and run her locally by using `npm start`.

## Contributing
Install Haruka as [mentioned above](#installation): create a fork with your changes, and issue a Pull Request. Haruka’s written in CoffeeScript, you can build her by running `coffee -o dist/ -cw src/` in the Terminal with CoffeeScript installed. It's also recommended you have a CoffeeScript linter installed.

## License

[MIT License][license]

<!-- Reference links -->
[github]: https://github.com/MindfulMinun/discord-haruka "MindfulMinun/discord-haruka"
[discord-my-apps]: https://discordapp.com/developers/applications/me "Discord - My Apps"
[license]: https://github.com/MindfulMinun/discord-haruka/blob/master/LICENSE "discord-haruka/LICENSE"
[add]: https://discordapp.com/oauth2/authorize?client_id=458130019554820127&scope=bot&permissions=125966 "Add Haruka to your Discord server."

<!-- Function links -->
[8ball]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/8ball.coffee
[about]:  https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/about.coffee
[help]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/help.coffee
[invite]: https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/invite.coffee
[pfp]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pfp.coffee
[ping]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/ping.coffee
[pkmn]:   https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/pkmn.coffee
[say]:    https://github.com/MindfulMinun/discord-haruka/blob/master/src/functions/say.coffee
