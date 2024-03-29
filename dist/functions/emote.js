// Generated by CoffeeScript 2.5.1
//! ========================================
//! Emote
var execRegex, handler;

execRegex = /^(emote|emoji)(\s+|$)/i;

handler = function(msg, match, Haruka) {
  var args, e, image, name, ref, ref1;
  args = match.input.replace(execRegex, '');
  //! Create / Delete
  args = args.split(/\s+/gi);
  switch (args[0]) {
    case "create":
      //! Create emote
      name = args[1];
      image = ((ref = msg.attachments.array()) != null ? (ref1 = ref[0]) != null ? ref1.url : void 0 : void 0) || args[2];
      //! Break if no image
      if ((name == null) || (image == null)) {
        return msg.reply("Attachment or URL wasn't provided. Use `-h help emote` for help with this command.");
      }
      msg.guild.createEmoji(image, name, null, `Haruka: Created emote as asked by ${msg.author.username} in Message<${msg.id}>`).then(function() {
        var e;
        e = msg.guild.emojis.find(function(e) {
          return e.name === name;
        });
        return msg.channel.send(`Emote created: \`:${name}:\``).then(function(sent) {
          return sent.react(e);
        });
      }).catch(function(err) {
        return msg.channel.send(`An error occurred: \n\`\`\`\n${err}\n\`\`\``);
      });
      break;
    case "delete":
      //! Delete emote
      name = args[1];
      if (name == null) {
        return msg.channel.send("An emote name wasn't provided. Please provide an emote name. Use `-h help emote` for help with this command.");
      }
      e = msg.guild.emojis.find(function(e) {
        return e.name === name;
      });
      if (e != null) {
        msg.guild.deleteEmoji(e, `Haruka: Deleted emote as asked by ${msg.author.username} in Message<${msg.id}>`).then(function() {
          return msg.channel.send(`Successfully deleted emote \`:${name}:\``);
        }).catch(function(err) {
          return msg.channel.send(`An error occurred: \n\`\`\`\n${err}\n\`\`\``);
        });
      } else {
        msg.reply([`That emote (\`:${name}:\`) doesn’t exist.`, "I can’t delete an emote that doesn’t exist!", "That emote isn’t from this server."].choose());
      }
      break;
    default:
      msg.reply(`Expected command to be either \`create\` or \`delete\`, was instead \`${args[0] || "empty"}\`. Use \`-h help emote\` for help with this command.`);
  }
};

module.exports = {
  name: "Emote",
  regex: execRegex,
  handler: handler,
  help: {
    short: "-h emote <...> :: Manages emotes.",
    long: `\`\`\`asciidoc
=== Help for Emote ===
*Aliases*: emote, emoji
-h emote create <name> ::
    Creates an emote. This requires an image to be attached.
-h emote create <name> <url> ::
    Creates an emote with the image located at the URL.
-h emote delete <name> ::
    Deletes an emote.

Example:
    -h emote create sayori_hmm https://puu.sh/B0Jgi/4ece28fd9f.jpg
    -h emote delete sayori_hmm
Note: When using \`create\`, attachments take precedence.
\`\`\``
  }
};
