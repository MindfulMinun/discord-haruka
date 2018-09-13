// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Version
  var Discord, formattedTime, handler, pkgname, ref, ref1;

  Discord = require('discord.js');

  pkgname = (ref = ((ref1 = require('../../package.json')) != null ? ref1.name : void 0) != null) != null ? ref : 'discord-haruka';

  formattedTime = function(secs) {
    var h, m, r, s;
    h = ~~(secs / 3600);
    m = ~~((secs % 3600) / 60);
    s = ~~(secs % 60);
    r = "";
    r += `${h}:` + (m < 10 ? '0' : '');
    r += `${m}:` + (s < 10 ? '0' : '');
    r += s;
    return r;
  };

  handler = function(msg, match, H) {
    var chosenBlob, embed;
    chosenBlob = H.config.about.blobs.choose();
    if (Array.isArray(chosenBlob)) {
      chosenBlob = chosenBlob.choose();
    }
    embed = new Discord.RichEmbed().setColor('#448aff').setTitle(`Haruka ${H.version}`).addField("Uptime", formattedTime(H.client.uptime / 1000)).setFooter(`${pkgname}@${H.version}`).setTimestamp(H.client.readyAt);
    return msg.channel.send(embed);
  };

  module.exports = {
    name: "Version",
    regex: /^(version|v)(\s+|$)/i,
    handler: handler,
    help: {
      hidden: true,
      long: "```asciidoc\n=== Help for Version ===\n*Aliases*: version, v\n-h version  :: Prints out technical information about Haruka.\n```"
    }
  };

}).call(this);
