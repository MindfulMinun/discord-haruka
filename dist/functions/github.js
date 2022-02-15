// Generated by CoffeeScript 2.5.1
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
      return reject({err, response, body});
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
      "User-Agent": require('../package.json').repository,
      "Content-Type": "application/json"
    }
  };
  return asyncReq(options).then(function(payload) {
    var data, embed, forks, issues, ref, stars;
    data = JSON.parse(payload.body);
    console.log(data);
    stars = (+data.stargazers_count || "None").toLocaleString();
    forks = (+data.forks || "None").toLocaleString();
    issues = (+data.open_issues || "None").toLocaleString();
    //! coffeelint: disable=max_line_length
    embed = new Discord.RichEmbed().setColor('#448aff').setTitle(data.full_name).setDescription(data.description).setURL(data.html_url).setThumbnail(data.owner.avatar_url).addField("Language", data.language, true).addField("License", ((ref = data.license) != null ? ref.name : void 0) || "None?", true).addField("Default Branch", data.default_branch, true).addField("Stargazers", stars, true).addField("Forks", forks, true).addField("Open issues", issues, true).setFooter("Last updated").setTimestamp(new Date(data.updated_at));
    // .addField "Last updated", "`#{lastUpdated}`", no
    // .setFooter "All times UTC"
    //! coffeelint: enable=max_line_length
    return msg.channel.send(embed);
  }).catch(function(err) {
    var ref;
    if ((err != null ? (ref = err.response) != null ? ref.statusCode : void 0 : void 0) === 404) {
      return msg.reply(["That repository wasn’t found. Make sure you’ve spelled the repository name correctly and try again.", "I couldn’t find that repository. Double-check the repository name and try again.", "I got a 404 error. Make sure you’ve spelled everything correctly and try again."].choose());
    } else {
      console.log(err);
      return msg.reply(["Sorry, but an unexpected error occurred.", "An unexpected error ocurred. Sorry about that."].choose());
    }
  });
};

module.exports = {
  name: "GitHub",
  regex: /^(github|git)(\s+|$)/i,
  handler: handler,
  help: {
    short: "-h github <..> :: Get information on any GitHub repository.",
    long: `\`\`\`asciidoc
=== Help for GitHub ===
*Aliases*: github, git
-h github <owner/repo> :: Retrieve information about a GitHub repository
Some examples:
    -h github lodash/lodash
    -h github MindfulMinun/discord-haruka
    -h github TheTimgor/sadbot
\`\`\``
  }
};
