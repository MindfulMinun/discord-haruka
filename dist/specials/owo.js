// Generated by CoffeeScript 2.5.1
//! ========================================
//! Special: owo
var handler;

handler = function(msg, Haruka) {
  var ref, reg;
  // Matches variations of "owo", preceded or followed by whitespace, case insensitive
  reg = /^\s*[ou][wmn][ou]\s*$/i;
  // Break if regex doesn't match.
  if ((!reg.test(msg.content)) || msg.author.bot) {
    return false;
  }
  // Do it one out of 3 times so it doesn't get too annoying
  if ((1 / 3) <= Math.random()) {
    return false;
  }
  if ((ref = msg.channel) != null) {
    ref.send(["What's this?", "uwu what's this???", "whats this"].choose());
  }
  // Message doesn't call Haruka, exit prematurely
  return true;
};

module.exports = {
  name: "Owo",
  handler: handler
};
