// Generated by CoffeeScript 2.5.1
//! ========================================
//! Function name
var handler;

handler = function(msg, match, Haruka) {
  var args;
  args = match.input.tokenize()[1];
  return msg.reply(`My example function. Arguments: \`${args}\``);
};

module.exports = {
  name: "Function name. Don’t forget to rename this",
  regex: /^(function|name)(\s+|$)/i,
  handler: handler,
  help: {
    short: "-h <fnName>    :: Does a thing. Don’t forget to replace this.",
    long: `\`\`\`asciidoc
=== Help for Function ===
*Aliases*: list, of, aliases
-h fn       :: Function without arguments.
-h fn <arg> :: Function with arguments.
\`\`\``
  }
};
