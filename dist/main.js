// Generated by CoffeeScript 2.3.1
// Require
var Haruka, config, fs, haruka;

fs = require('fs');

config = require('../config.json');

Haruka = require('./Haruka');

(function() {
  var p;
  require('dotenv').config();
  p = require('../package.json');
  config.version = `v${p.version || "?.?.?"}`;
  config.name = p.name;
  config.dev = !/production/i.test(process.env.NODE_ENV || '');
  return config.ops = (process.env.HARUKA_OPS || '').split(',');
})();

// Start
haruka = new Haruka({
  prefix: config.dev ? '#h' : '-h',
  config: config,
  default: function(msg) {
    // console.log msg.content
    // c = msg.content.replace(@prefix, '').trim()
    // console.log c
    // if c is ''
    //     # Call the Help function if no arguments provided.
    //     help = @functions.find((f) -> f.name is 'Help')
    //     help.handler(msg, null, @)
    // else
    return msg.reply(["Hmm, I'm not sure what you mean by that.", "Sorry, I don't know what you meant by that.", "I’m not sure I understand.", "I’m not sure what you mean."].choose() + " Try `-h help` for a list of commands.");
  }
});

// ========================================
// Add event listeners
haruka.client.on('ready', function() {
  var d;
  d = new Date;
  haruka.client.user.setActivity('Hentai | -h help', {
    type: 'WATCHING'
  });
  if (config.dev) {
    return console.log(`Started Haruka in DEVELOPMENT mode.\nLogged in as ${haruka.client.user.tag} on ${d.toUTCString()}.`);
  } else {
    return console.log(`Logged in as ${haruka.client.user.tag} on ${d.toUTCString()}.`);
  }
});

haruka.client.on('message', function(msg) {
  var err, r;
  try {
    return haruka.try(msg);
  } catch (error) {
    err = error;
    //! I hope this catches bugs
    r = new RegExp(process.cwd(), 'gi');
    msg.channel.send(`**An exception has occurred:** This is a bug, this shouldn’t happen.\nCreate a GitHub issue or contact me via Discord (MindfulMinun#3386).\nInformation regarding the exception is provided below.\n(I hope Monika has nothing to do with this.)\n\`\`\`\n${err.stack.replace(r, '~')}\n\`\`\``);
    return console.warn("\n===== Uncaught Fatal Error: =====\n", err);
  }
});

// ========================================
// Add functions

// Take Haruka's functions and add them to the queue
fs.readdirSync(`${__dirname}/functions`).filter(function(filename) {
  return /^(?:[^_]).+(?:\.(?:coffee|js))/.test(filename);
}).forEach(function(filename) {
  return haruka.add('function', require(`${__dirname}/functions/${filename}`));
});

// Likewise, take Haruka's special functions and add them to the other queue
fs.readdirSync(`${__dirname}/specials`).filter(function(filename) {
  return /^(?:[^_]).+(?:\.(?:coffee|js))/.test(filename);
}).forEach(function(filename) {
  return haruka.add('special', require(`${__dirname}/specials/${filename}`));
});

//! Catch uncaught rejections and continue normally.
process.on('unhandledRejection', function(err) {
  return console.log("===== Uncaught Promise Rejection: =====\n", err);
});

(function() {  //! ========================================
  //! Helpers
  Array.prototype.choose = function() {
    //! Choose a random element from this array.
    return this[Math.floor(Math.random() * this.length)];
  };
  Array.prototype.last = function() {
    //! Retrieve this array's last element.
    return this[this.length - 1];
  };
  Array.prototype.first = function() {
    //! Retrieve this array’s first element (for chained calls)
    return this[0];
  };
  return String.prototype.tokenize = function() {
    //! Split this string at the first occurrence of whitespace.
    return this.replace(/\s+/, '\x01').split('\x01');
  };
})();

//! ========================================
//! Finally, log Haruka in.
haruka.client.login(process.env.DISCORD_TOKEN);

console.log(haruka);
