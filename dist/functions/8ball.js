// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! 8-ball
  var Discord, handler;

  Discord = require('discord.js');

  handler = function(msg, match, H) {
    var answer, embed, q;
    q = match.input.tokenize()[1];
    if (!q) {
      return msg.reply(["Ask a question, and I’ll reveal the universe’s secrets or something.", "I’m an all-knowing being; I will answer any question using `Math.random()`. Now then, what’s your question?"].choose());
    }
    answer = ["It is certain.", "It is decidedly so.", "Without a doubt.", "Yes - definitely.", "You may rely on it.", "As I see it, yes.", "Most likely.", "Outlook good.", "Yes.", "Signs point to yes.", "Reply hazy, try again", "Ask again later.", "Better not tell you now.", "Cannot predict now.", "Concentrate and ask again.", "Don't count on it.", "My reply is no.", "My sources say no", "Outlook not so good.", "Very doubtful."].choose();
    embed = new Discord.RichEmbed().setColor('#448aff').setTitle(answer);
    // .setDescription answer
    return msg.channel.send(embed);
  };

  module.exports = {
    name: "8-ball",
    regex: /^(?:8\-ball|8ball|ask)\s*/i,
    handler: handler,
    help: {
      short: "-h 8ball <???> :: Answers any yes or no question.",
      long: "```asciidoc\n=== Help for 8-ball ===\n*Aliases*: 8-ball, 8ball, ask\n-h 8ball <question> :: Answers any yes or no question with 47.2% certainty.\n```"
    }
  };

}).call(this);
