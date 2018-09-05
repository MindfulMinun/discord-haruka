// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Dab
  var handler;

  handler = function(msg, Haruka) {
    var ref, rin_dab;
    // React with the dabbing emote every time some1 says
    // "dab" or "dabbing" in timgor's server

    // Check if the message was sent from tim's server (not by a bot)
    // Check if the message includes "dab" or "dabbing"
    if (msg.author.bot || ((ref = msg.guild) != null ? ref.id : void 0) !== "443094449233592325") {
      return;
    }
    // If a message contains "dab" or "dabbing", react with the :rin_dab: emote
    if (/\b(dab(bing)?)\b/gi.test(msg.content)) {
      rin_dab = msg.guild.emojis.find('name', 'rin_dab');
      msg.react(rin_dab);
      return false;
    }
  };

  module.exports = {
    name: "Dab",
    handler: handler
  };

}).call(this);
