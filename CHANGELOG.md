# Development version v1.2.0-dev
Started: 2018-06-23

### Added
- GitHub function:
    - `[2018-06-24]`: GitHub function: Retrieves information about a GitHub repository. Syntax: `-h github <user/repo>`
    - `[2018-06-25]`: Added `.catch` statements
    - `[2018-06-25]`: Added stargazers, forks, and issues counter

- Kanji function:
    - `[2018-06-25]`: Kanji function: Looks up info about a Kanji character. Syntax: `-h kanji <kanji>`

### Changed
- Pokémon function:  
    - `[2018-06-24]`: The `RichEmbed` now displays data inline.
- Help function and each function's `module.exports`:
    - `[2018-06-25]`: `help` in each function's `module.exports` now has two properties, `short` and `long`. `short` appears in `-h help`, and `long` appears in `-h help <fn>`


### Removed
_Nothing yet._
___

# [Release v1.1.0 (2018-06-23)](https://github.com/MindfulMinun/discord-haruka/releases/tag/v1.1.0)
_aka: Haruka’s First Release_

Create a `config.json` file at root as described in the `README`. Then, start Haruka by running either `npm start` or `node dist/main.js`.

Commands:
- `-h 8ball`: Answers any yes or no question.
- `-h about`: General stuff about Haruka.
- `-h help`: Returns a list of all the commands, much like this one.
- `-h invite`: Replies with a URL to invite Haruka to other servers.
- `-h pfp`: Return a user’s profile image as a URL
- `-h ping`: Replies “Pong!”
- `-h pkmn`: Gets information about a Pokémon.
- `-h say`: Replies with whatever you tell it to.
