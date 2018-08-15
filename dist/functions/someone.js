// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Someone
  var handler;

  handler = function(msg, match, Haruka) {
    var args, lucky, members, ref;
    //! Choose a random member
    if (msg.guild == null) {
      return msg.reply(["You have to be in a server to use this command.", "This command only works in servers, not DMs or GroupDMs.", "It doesn’t look like you’re in a server, so I can’t run that command."].choose());
    }
    args = match.input.tokenize()[1];
    members = (ref = msg.channel) != null ? ref.members : void 0;
    lucky = (function() {
      switch (args) {
        case "online":
          return members != null ? members.filter(function(m) {
            return (m != null ? m.presence.status : void 0) === 'online';
          }) : void 0;
        case "offline":
          return members != null ? members.filter(function(m) {
            return (m != null ? m.presence.status : void 0) === 'offline';
          }) : void 0;
        case "dnd":
          return members != null ? members.filter(function(m) {
            return (m != null ? m.presence.status : void 0) === 'dnd';
          }) : void 0;
        case "idle":
          return members != null ? members.filter(function(m) {
            return (m != null ? m.presence.status : void 0) === 'idle';
          }) : void 0;
        default:
          return members != null ? members.filter(function(m) {
            var ref1;
            return (ref1 = m != null ? m.presence.status : void 0) === 'online' || ref1 === 'idle';
          }) : void 0;
      }
    })();
    if (lucky = lucky.random()) {
      return msg.channel.send([`${lucky}, you’re the chosen one.`, `${lucky}, you’ve been summoned.`, `${lucky}, consider yourself lucky.`].choose());
    } else {
      return msg.reply([`Hmm, I couldn’t choose a random user who’s \`${args != null ? args : 'online'}\`.`, "I can’t seem to find someone with those criteria.", `I didn’t find anyone who’s \`${args != null ? args : 'online'}\`.`].choose() + " See `-h h someone` for details on this command.");
    }
  };

  module.exports = {
    name: "Someone",
    regex: /^@?(someone|somebody)(\s+|$)/i,
    handler: handler,
    help: {
      // P for presence
      short: "-h someone [p] :: Mentions a random user.",
      long: "```asciidoc\n=== Help for Someone ===\n*Aliases*: @someone, @somebody, someone, somebody\n-h someone         :: Mentions a random user that’s online.\n-h someone online  :: Mentions a random user that’s online.\n-h someone offline :: Mentions a random user that’s offline.\n-h someone idle    :: Mentions a random user that’s idle.\n-h someone dnd     :: Mentions a random user that’s in Do Not Disturb.\n*Note*: This function only works in servers, not DMs or GroupDMs.\n```"
    }
  };

}).call(this);
