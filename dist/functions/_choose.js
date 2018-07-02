// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Choose
  var handler;

  handler = function(msg, match, Haruka) {
    var args;
    args = match.input.tokenize()[1];
    return msg.reply(`My example function. Arguments: \`${args}\``);
  };

  module.exports = {
    name: "Choose",
    regex: /^(choose)(\s+|$)/i,
    handler: handler,
    help: {
      short: "-h choose      :: Does something.",
      long: "```asciidoc\n=== Help for Choose ===\n*Aliases*: list, of, aliases\n-h fn       :: Function without arguments.\n-h fn <arg> :: Function with arguments.\n```"
    }
  };

}).call(this);
