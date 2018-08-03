// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Function name
  var handler;

  handler = function(msg, match, H) {
    return msg.reply(`Running Haruka \`${H.version}\` ${(H.dev ? "(Development mode)" : "")}, with ${H.functions.length} functions and ${H.specials.length} specials.`);
  };

  module.exports = {
    name: "Version",
    regex: /^(version|v)(\s+|$)/i,
    handler: handler,
    help: {
      hidden: true,
      short: "",
      long: "```asciidoc\n=== Help for Version ===\n*Aliases*: version, v\n-h version  :: Prints out version information about Haruka.\n```"
    }
  };

}).call(this);
