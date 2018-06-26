// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Poll
  //! -h poll [<Question?>] [<ans>]
  /*
   * Syntax: -h poll [Question] [<ans1> <ans2> <ans3> <...>]
   * Ex:     -h poll [Who is best girl?] [<Haruka> <Haruka> <Haruka>]
   */
  var handler;

  handler = function(msg, match, Haruka) {
    var args;
    args = match.input.tokenize()[1];
    return msg.reply(`My example function. Arguments: \`${args}\``);
  };

  module.exports = {
    name: "Poll",
    regex: /^(poll)(\s+|$)/i,
    handler: handler,
    help: {
      short: "-h poll        :: Does polls.",
      long: "```asciidoc\n=== Help for Function ===\n*Aliases*: list, of, aliases\n-h fn       :: Function without arguments.\n-h fn <arg> :: Function with arguments.\n```"
    }
  };

}).call(this);