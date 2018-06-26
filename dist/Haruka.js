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
  var Haruka, HarukaFns, file, fnObj, fs, i, j, len, len1;

  Haruka = {};

  Haruka.dev = true;

  Haruka.version = "v1.2.0-dev";

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

  for (i = 0, len = HarukaFns.length; i < len; i++) {
    file = HarukaFns[i];
    fnObj = require(`../dist/functions/${file}`);
    Haruka.addFunction(fnObj);
  }

  //! ========================================
  //! Take Haruka's special funcitons and add them to the other queue
  HarukaFns = fs.readdirSync('./dist/specials').filter(function(file) {
    return file.endsWith('.js') && !file.startsWith("_");
  });

  for (j = 0, len1 = HarukaFns.length; j < len1; j++) {
    file = HarukaFns[j];
    fnObj = require(`../dist/specials/${file}`);
    Haruka.addSpecial(fnObj);
  }

  Haruka.try = function(msg) {
    var fn, k, l, len2, len3, ref, ref1, regexMatch, txt;
    ref = Haruka.specials;
    //! ========================================
    //! Run Specials first
    for (k = 0, len2 = ref.length; k < len2; k++) {
      fn = ref[k];
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
    //! Show a warning if Haruka's in dev mode
    if (Haruka.dev) {
      msg.reply("I'm in **development** mode, stuff may break. Use `#h` instead of `-h`.");
    }
    ref1 = Haruka.functions;
    //! Run through all the commands and see if one matches.
    for (l = 0, len3 = ref1.length; l < len3; l++) {
      fn = ref1[l];
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
