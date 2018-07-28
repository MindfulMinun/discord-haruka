// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Now

  //! Embed
  var Discord, handler, months, weekdays;

  Discord = require('discord.js');

  //! Use arrays and stuff to have more control over output
  months = ['January', 'Febuary', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  handler = function(msg, match, Haruka) {
    var D, M, W, Y, d, embed, h, m, now, s;
    //! Use the message sent time bc I don't want to deal with lag.
    now = new Date(msg.createdTimestamp);
    d = "";
    Y = now.getUTCFullYear();
    M = months[now.getUTCMonth()];
    D = now.getUTCDate();
    W = weekdays[now.getUTCDay()];
    h = (now.getUTCHours() + "").padStart(2, '0');
    m = (now.getUTCMinutes() + "").padStart(2, '0');
    s = (now.getUTCSeconds() + "").padStart(2, '0');
    d += `${W}, ${M} ${D}, ${Y} ${h}:${m}:${s}`;
    embed = new Discord.RichEmbed().setColor('#448aff').setTitle('Current Time (UTC)').setDescription(d).setFooter(now.toISOString().slice(0, 19).replace('T', ' ')).setTimestamp(now).setURL(`https://www.timeanddate.com/worldclock/converter.html?iso=${now.toISOString().slice(0, 19).replace(/[:-]/g, '')}&p1=1440`);
    return msg.channel.send(embed);
  };

  module.exports = {
    name: "Function",
    regex: /^(now|time|date)(\s+|$)/i,
    handler: handler,
    help: {
      short: "-h now         :: Returns the current time in UTC.",
      long: "```asciidoc\n=== Help for Now ===\n*Aliases*: now, time, date\n-h now :: Gets the current time (UTC).\n```"
    }
  };

}).call(this);
