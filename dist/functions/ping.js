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
    var delta, p;
    p = Haruka.client.ping;
    delta = reply.createdTimestamp - msg.createdTimestamp;
    return reply.edit(`${reply.content} (WebSocket: ${p.toFixed(3)}ms, Reaction: ${delta.toFixed(3)}ms, Delivery: ${(delta - p).toFixed(3)}ms)`);
  });
};

module.exports = {
  name: "Ping",
  regex: /^(ping|beep|ding|uwu|owo|awoo)!?(\s+|$)/i,
  handler: handler,
  help: {
    short: "-h ping        :: Replies “Pong!”",
    long: "```asciidoc\n=== Help for Ping ===\n*Aliases*: ping, beep, ding, owo, uwu, awoo\n-h ping :: Replies \"Pong!\" along with the time it took to reply.\n-h beep :: Replies \"Boop!\" along with the time it took to reply.\n-h ding :: Replies \"Dong!\"...\n-h uwu  :: Replies \"OwO\"...\n-h owo  :: Replies \"uwu\"...\n-h awoo :: Replies \"Awoo!\"...\n*Note(s):*\n    The WebSocket time is the mean of the last 3 heartbeat\n        pings of Haruka's WebSocket.\n    The Reaction time is raw difference between you sending the\n        command and Haruka repling to it.\n    The Delivery time is Haruka's Reaction time minus\n        internal evaluation time.\n```"
  }
};
