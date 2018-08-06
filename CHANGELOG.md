# Development version v1.4

### Changed
- Main.coffee:
    - Uncaught errors now print their stack traces.
- Purge
    - Users must now have relevant permissions before purging messages.
- Dad (Special)
    - DM'ing Haruka causes an error loop to occur, fixed with a single `?`, another reason to love CoffeeScript.

---

# [Release v1.3.0](https://github.com/MindfulMinun/discord-haruka/releases/tag/v1.3.0)
Four new functions, one new special:
- Someone function
    - Use `-h @someone` to mention a user chosen at random.
- Emote function
    - Manage server emotes and emojis with `-h emote`
- Now function
    - Get the current UTC time with `-h now`
- Purge function
    - Delete messages in bulk using `-h purge`
- Dab special function
    - Reacts with a dabbing emote if you say "dab" or "dabbing" in a certain server.

**Note:** `Haruka.version` and `Haruka.dev` have been moved to `config.json`

---

# Development version v1.3

### Added
- Someone function
    - `[2018-07-20]`: Created someone function, use `-h @someone` to mention a random user, offline or online.
- Emote function
    - `[2018-07-21]`: Manage server emotes and emojis with `-h emote`.
- Now function
    - `[2018-07-28]`: Get the current UTC time with `-h now`
- Dab Special function
    - `[2018-07-28]`: Reacts with a dabbing emote if you say "dab" or "dabbing" in a certain server.

### Changed
- Use `npm run debug` as a shortcut for `node --inspect dist/main.js`.
- Added bug report issue template.
- Moved `version` and `dev` to `config.json`

### Removed
- Nothing yet...

---

# [Release v1.2.2](https://github.com/MindfulMinun/discord-haruka/releases/tag/v1.2.2)
Killing bugs:
- Fixes Haruka’s Dad special. This special would throw an error and wouldn't run, which has now been resolved.

# [Release v1.2.1](https://github.com/MindfulMinun/discord-haruka/releases/tag/v1.2.1)

Three new functions, one new special:
- Aesthetic function
    - `-h ae <text>` turns text into ｗｉｄｅｒ，　ｍｏｒｅ　ａｅｓｔｈｅｔｉｃ　ｔｅｘｔ．
- Version function
    - `-h version` prints out Haruka’s current version, as well as the number of functions she has available.
- Restart function
    - Use `-h restart` to restart the Haruka instance. User must be in the `ops` list.
- Dad special function
    - If a message starts with "I’m" (or something like it), Haruka has a 1 in 10 chance of sending a sarcastic reply.

---

# Development version v1.2.1

### Added
- Halt function
    - `[2018-07-01]`: Created function: Users in `ops` in `config.json` can run the `-h halt` command to halt Haruka.
- Version function
    - `[2018-07-03]`: Created hidden function: `-h version` prints out Haruka’s current version, as well as the number of functions she has available.
- Play function
    - `[2018-07-05]`: Created function: `-h play <url or id>` plays YouTube videos. Code could be better written.
- Aesthetic function
    - `[2018-07-14]`: Created function: `-h ae <text>` turns text into ｗｉｄｅｒ，　ｍｏｒｅ　ａｅｓｔｈｅｔｉｃ　ｔｅｘｔ．

### Changed
- `[2018-07-01]`: Changed activity to `Watching Hentai | -h help` because I think I'm clever.
- `[2018-07-04]`: Cleaned up the `pkmn` function.
- `[2018-07-14]`: Removed the `play` function from being added to Haruka, prefixed with an underscore.

### Removed
- Nothing yet...


---

# [Release v1.2.0](https://github.com/MindfulMinun/discord-haruka/releases/tag/v1.2.0)

Added two new functions:
- GitHub function
    - Retrieves information about a GitHub repository. Syntax: `-h github <user/repo>`
- Kanji function
    - Looks up info about a Kanji character. Syntax: `-h kanji <kanji>`

Created Special functions, which are functions that listen to every message, used for only
    _special circumstances_ (i.e., making an April fools prank, writing joke
    replies, etc).

___

# Development version v1.2.0-dev
Started: 2018-06-23

### Added
- GitHub function:
    - `[2018-06-24]`: GitHub function: Retrieves information about a GitHub repository. Syntax: `-h github <user/repo>`
    - `[2018-06-25]`: Added `.catch` statements
    - `[2018-06-25]`: Added stargazers, forks, and issues counter

- Kanji function:
    - `[2018-06-25]`: Kanji function: Looks up info about a Kanji character. Syntax: `-h kanji <kanji>`

- Special functions:
    - `[2018-06-26]`: Special functions are functions that listen to every message, used for only
        _special circumstances_ (i.e., making an April fools prank, writing joke
        replies, etc).
    - `[2018-06-26]`: Added README for Special functions.

- Everything:
    - `[2018-06-25]`: Added `example-config.json` and included it in the README.
    - `[2018-06-25]`: Standardized Regexes
    - `[2018-06-26]`: Added boilerplates

### Changed
- Pokémon function:  
    - `[2018-06-24]`: The `RichEmbed` now displays data inline.
- Help function and each function's `module.exports`:
    - `[2018-06-25]`: `help` in each function's `module.exports` now has two properties, `short` and `long`. `short` appears in `-h help`, and `long` appears in `-h help <fn>`

### Removed
- Config function:
    - `[2018-06-26]`: Removed `_config` function, as it wasn’t being worked on.
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
