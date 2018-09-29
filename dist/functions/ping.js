// Generated by CoffeeScript 2.3.1
//! ========================================
//! Ping
var handler;

handler = function(msg, match, Haruka) {
  var input;
  input = match[1].toLowerCase();
  return ((function() {
    switch (input) {
      case "ping":
        return msg.reply("Pong!");
      case "beep":
        return msg.reply("Boop!");
      case "ding":
        return msg.reply("Dong!");
      case "awoo":
        return msg.reply("Awoo!");
      case "uwu":
        return msg.reply("OwO");
      case "owo":
        return msg.reply("uwu");
      default:
        return msg.reply("Pong!");
    }
  })()).then(function(reply) {
    var delta;
    delta = reply.createdTimestamp - msg.createdTimestamp;
    return reply.edit(`${reply.content} (${delta}ms)`);
  });
};

module.exports = {
  name: "Ping",
  regex: /^(ping|beep|ding|uwu|owo|awoo)!?(\s+|$)/i,
  handler: handler,
  help: {
    short: "-h ping        :: Replies “Pong!”",
    long: "```asciidoc\n=== Help for Ping ===\n*Aliases*: ping, beep, ding, owo, uwu, awoo\n-h ping :: Replies \"Pong!\" along with the time it took to reply.\n-h beep :: Replies \"Boop!\" along with the time it took to reply.\n-h ding :: Replies \"Dong!\" along with the time it took to reply.\n-h uwu  :: Replies \"OwO\" along with the time it took to reply.\n-h owo  :: Replies \"uwu\" along with the time it took to reply.\n-h awoo :: Replies \"Awoo!\" along with the time it took to reply.\n```"
  }
};
