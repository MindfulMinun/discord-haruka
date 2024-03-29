// Generated by CoffeeScript 2.5.1
  //! ========================================
  //! Kick
var handler,
  indexOf = [].indexOf;

handler = function(msg, match, Haruka) {
  var canKickAll, members;
  members = msg.mentions.members;
  if (!members.size) {
    return msg.reply(["Do you even know how to use this command...?", "Don’t use such a powerful command if you don’t know how to use it."].choose());
  }
  canKickAll = members.every(function(member) {
    var ref;
    // Override permissions if the executor is an op.
    return member.kickable || (ref = msg.author.id, indexOf.call(Haruka.config.ops, ref) >= 0);
  });
  if (canKickAll) {
    return members.tap(function(member) {
      return member.kick().then(function() {
        return msg.channel.send([`Nice, I kicked ${member} successfully.`, `Cool, ${member} was kicked.`, `Bye bye, ${member}, you've been kicked.`].choose());
      }).catch(function(err) {
        return msg.reply(["Heck, I couldn't do that.", "Something happened.", "Dang, I wasn't able to do that."].choose() + `\n\`\`\`${err}\`\`\``);
      });
    });
  } else {
    return msg.reply(["You think you can do that? Nice try.", "I refuse to run that command.", "Who do you think you are, a mod?"].choose());
  }
};

module.exports = {
  name: "Kick",
  regex: /^(kick|eject)(\s+|$)/i,
  handler: handler,
  help: {
    short: "-h kick        :: Kicks mentioned users.",
    hidden: true,
    long: `\`\`\`asciidoc
=== Help for kick ===
*Aliases*: kick, eject
-h kick <user...> :: Kicks all the mentioned users.
Example:
    -h kick @MindfulMinun @Haruka
Note: Both you and I must be able to kick *all* mentioned users.
      This function fails even if only 1 member can't be kicked.
\`\`\``
  }
};
