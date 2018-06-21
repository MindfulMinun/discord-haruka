# Haruka

Haruka, your useless Discord bot.

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
[license]: https://github.com/MindfulMinun/discord-haruka/blob/development/LICENSE "discord-haruka/LICENSE"
