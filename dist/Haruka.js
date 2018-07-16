// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Creating Haruka
  /*
   * The message handlers will be passed a snapshot of the Haruka instance.
   * The Haruka instance will have the following structure:

      Haruka {
          dev: Boolean
          functions: [{
              name: String
              regex: RegExp
              handler: Function
              help: String
          }, ...]
          specials: [{
              name: String
              handler: Function
          }, ...]
          prefix: Enum('-h', '#h')
          addFunction: Function
          try: Function
          config: JSON
      }
   */
  var Haruka, HarukaFns, HarukaSpecials, f, fs;

  Haruka = {};

  Haruka.dev = false;

  Haruka.version = "v1.3.0-dev";

  Haruka.functions = [];

  Haruka.specials = [];

  Haruka.prefix = Haruka.dev ? '#h' : '-h';

  //! ========================================
  //! Modules
  fs = require('fs');

  //! ========================================
  //! Helper functions
  Array.prototype.choose = function() {
    return this[Math.floor(Math.random() * this.length)];
  };

  Haruka.addFunction = function(fnObj) {
    return Haruka.functions.push(fnObj);
  };

  Haruka.addSpecial = function(fnObj) {
    return Haruka.specials.push(fnObj);
  };

  //! ========================================
  //! Take Haruka's functions and add them to the queue
  HarukaFns = fs.readdirSync('./dist/functions').filter(function(file) {
    return file.endsWith('.js') && !file.startsWith("_");
  });

  (function() {
    var i, len, results;
    results = [];
    for (i = 0, len = HarukaFns.length; i < len; i++) {
      f = HarukaFns[i];
      results.push(Haruka.addFunction(require(`../dist/functions/${f}`)));
    }
    return results;
  })();

  //! ========================================
  //! Take Haruka's special funcitons and add them to the other queue
  HarukaSpecials = fs.readdirSync('./dist/specials').filter(function(file) {
    return file.endsWith('.js') && !file.startsWith("_");
  });

  (function() {
    var i, len, results;
    results = [];
    for (i = 0, len = HarukaSpecials.length; i < len; i++) {
      f = HarukaSpecials[i];
      results.push(Haruka.addSpecial(require(`../dist/specials/${f}`)));
    }
    return results;
  })();

  Haruka.try = function(msg) {
    var fn, i, j, len, len1, ref, ref1, regexMatch, txt;
    ref = Haruka.specials;
    //! ========================================
    //! Run Specials first
    for (i = 0, len = ref.length; i < len; i++) {
      fn = ref[i];
      //! Break if handler returns a truthy value.
      if (fn.handler(msg, Haruka)) {
        return;
      }
    }
    //! ========================================
    //! Functions

    //! Tokenize input
    txt = msg.content.tokenize();
    txt[1] = txt[1] ? txt[1] : "help";
    //! Check if the message starts with the prefix,
    //! and it's not from another bot.
    if ((txt[0] !== Haruka.prefix) || msg.author.bot) {
      return;
    }
    ref1 = Haruka.functions;
    //! Show a warning if Haruka's in dev mode
    //! This is actually very annoying, I regret adding this.
    // if Haruka.dev
    //     msg.reply "I'm in **development** mode, stuff may break.
    //         Use `#h` instead of `-h`."

    //! Run through all the commands and see if one matches.
    for (j = 0, len1 = ref1.length; j < len1; j++) {
      fn = ref1[j];
      regexMatch = fn.regex.exec(txt[1]);
      if (regexMatch) {
        return fn.handler(msg, regexMatch, Haruka);
      }
    }
    //! Catchall
    return msg.reply(["Hmm, I'm not sure what you mean by that.", "Sorry, I don't know what you meant by that.", "I’m not sure I understand.", "I’m not sure what you mean."].choose() + " Try `-h help` for a list of commands.");
  };

  module.exports = Haruka;

}).call(this);
