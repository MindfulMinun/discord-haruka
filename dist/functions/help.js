// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Help
  var handler;

  handler = function(msg, match, H) {
    var fn, helpMatch, i, len, ref;
    if (H.dev) {
      msg.reply("I'm in **development** mode, stuff may break. Use `#h` instead of `-h`.");
    }
    if (match[1] && match[1].length) {
      ref = H.functions;
      for (i = 0, len = ref.length; i < len; i++) {
        fn = ref[i];
        helpMatch = fn.regex.test(match[2]);
        if (helpMatch) {
          return msg.channel.send(fn.help);
        }
      }
    }
    return msg.channel.send("Here's a list of all my commands. Arguments in `<angle brackets>` are required, and those in `[regular brackets]` are optional.\n```asciidoc\n=== Commands ===\nabout      :: General stuff about me.\nchat       :: Start a conversation with me!\nhelp [...] :: This list. What did you expect?\ninvite     :: Replies with the URL to invite me to other servers.\npfp        :: Returns your profile image as a URL\nping       :: Replies “Pong!”\npkmn       :: Get information regarding a Pokémon (Try -h help pkmn)\nsay <...>  :: Replies with <...>\n```");
  };

  module.exports = {
    name: "Help",
    regex: /^(help|h)\s*(\S[\s\S]*)?$/i,
    handler: handler,
    help: "```asciidoc\n=== Help for Help (so meta) ===\n*Aliases*: help, h\n-h help :: Returns a help menu listing all the commands.\n-h help [command] :: Returns a help menu for that specific command.\n```"
  };

}).call(this);
