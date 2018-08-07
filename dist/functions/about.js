// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! About
  var handler;

  handler = function(msg, match, H) {
    return msg.reply(`Hi, I’m Haruka, your useless bot (\`${H.version}\`). I’m made out of CoffeeScript and dedication. I was created by MindfulMinun.\n - **Twitter:** https://twitter.com/MindfulMinun\n - **GitHub repo:** https://github.com/MindfulMinun/discord-haruka/\n - **How I work:** https://benjic.xyz/2018-07-30/haruka-teardown/?s=1`);
  };

  module.exports = {
    name: "About",
    regex: /^(about)(\s+|$)/i,
    handler: handler,
    help: {
      short: "-h about       :: General stuff about me.",
      long: "```asciidoc\n=== Help for About ===\n*Aliases*: None.\n-h about :: Prints some info about me, Haruka!\n```"
    }
  };

}).call(this);
