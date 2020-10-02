// Generated by CoffeeScript 2.5.1
//! ========================================
//! Health
var handler;

handler = function(msg, match, Haruka) {
  // Courtesy of @not Qualitytoons#4293
  // He says he stole them from dhmis 5
  return msg.reply(["Stealing memes is healthy.", "What’s that, a tasty snack? Don’t eat tasty.", "Don’t eat pizza, eat plain white sauce.", "Chicken sticks are better than beef and fish.", "If you eat in excess your teeth might go grey.", "Your body is like a house. With blood, hair, and organs.", "The healthy food (bread) is polite and nice to your organs, but the mean food (carrot) is very rude to everyone.", "If you eat a sandwich you’ll end up with your gums all grey.", "The food groups can easily be sorted using the simple health shape (google it).", "If you eat plain foods, such as: bread, cream, white sauce and aspic your body will function.", "Fancy foods such as cooked meats, fruit salads, vegetables and yolk clog up your body with unnecessary detail", "Pizza, bread and cheese taste so nice.", "Pretty pies make you be sad inside.", "Just eat yeast and soy milk.", "Don’t put foods that are not Haruka branded in your mouth.", "Try out onion paste, looks like fun, have a taste.", "Don’t eat food from a stranger’s plate."].choose());
};

module.exports = {
  name: "Health",
  regex: /^(health)(\s+|$)/i,
  handler: handler,
  help: {
    short: "-h health      :: Tips to improve your bodily health.",
    long: `\`\`\`asciidoc
=== Help for health ===
*Aliases*: health
-h health :: Sends a random tip to improve your bodily health.
\`\`\``
  }
};
