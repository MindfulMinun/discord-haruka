// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! GitHub
  var Discord, asyncReq, handler, request;

  Discord = require('discord.js');

  request = require('request');

  asyncReq = function(options) {
    return new Promise(function(resolve, reject) {
      return request(options, function(err, response, body) {
        var ref;
        if (!err && ((200 <= (ref = response.statusCode) && ref < 400))) {
          return resolve({response, body});
        }
        return reject({error, response, body});
      });
    });
  };

  //! ========================================
  //! Message handler
  handler = function(msg, match, H) {
    var options, repo;
    repo = match.input.tokenize()[1];
    if (!repo) {
      return msg.reply(["Use `-h github` followed by GitHub repo you want me to look up.", "I can look up any GitHub repository if you use `-h github` followed by the user or organization, a slash, then the repository name.", "You’re missing a few arguments. Try `-h help github` if you forgot this command’s syntax."].choose());
    }
    options = {
      url: "https://api.github.com/repos/" + repo,
      method: "GET",
      headers: {
        "User-Agent": `Node.js ${process.version} on Ubuntu 16.04`,
        "Content-Type": "application/json"
      }
    };
    return asyncReq(options).then(function(payload) {
      var DateUTC, data, embed, lastUpdated, ref;
      data = JSON.parse(payload.body);
      DateUTC = function(date) {
        //! Formats Dates in a way I hope everyone can understand.
        if (date == null) {
          date = new Date();
        }
        date = new Date(date).toISOString().slice(0, 19).replace('T', ' ');
        return date + " UTC";
      };
      lastUpdated = DateUTC(data.updated_at);
      //! coffeelint: disable=max_line_length
      embed = new Discord.RichEmbed().setColor('#448aff').setTitle(data.full_name).setDescription(data.description).setURL(data.html_url).setThumbnail(data.owner.avatar_url).addField("Language", data.language, true).addField("License", ((ref = data.license) != null ? ref.name : void 0) || "None?", true).addField("Default Branch", data.default_branch, true).addField("Last updated", `\`${lastUpdated}\``, false);
      // .setFooter "All times UTC"
      //! coffeelint: enable=max_line_length
      return msg.channel.send(embed);
    });
  };

  module.exports = {
    name: "GitHub",
    regex: /^(github|git)(\s+|$)/i,
    handler: handler,
    help: "```asciidoc\n=== Help for GitHub ===\n*Aliases*: github, git\n-h github <owner/repo> :: Retrieve information about a GitHub repository\nSome examples:\n    -h github jquery/jquery\n    -h github notwaldorf/tiny-care-terminal\n    -h github mindfulminun/discord-haruka\n```"
  };

}).call(this);
