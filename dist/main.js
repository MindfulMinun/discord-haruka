// Generated by CoffeeScript 2.3.1
(function() {
  //! ========================================
  //! Haruka Setup
  var Discord, Haruka, client, config, fs;

  fs = require('fs');

  Discord = require('discord.js');

  config = require('../config.json');

  Haruka = require('./Haruka.js');

  client = new Discord.Client;

  Haruka.config = config;

  //! ========================================
  //! Add event listeners
  client.on('ready', function() {
    var d;
    d = new Date;
    client.user.setActivity('Try -h help');
    if (Haruka.dev) {
      return console.log(`Started Haruka in DEVELOPMENT mode.\nLogged in as ${client.user.tag} on ${d.toUTCString()}.`);
    } else {
      return console.log(`Logged in as ${client.user.tag} on ${d.toUTCString()}.`);
    }
  });

  client.on('message', function(msg) {
    return Haruka.try(msg);
  });

  //! Catch Uncaught rejections and continue normally.
  process.on('unhandledRejection', function(err) {
    return console.log("===== Uncaught Promise Rejection: =====\n", err);
  });

  //! ========================================
  //! Helpers
  Array.prototype.choose = function() {
    //! Choose a random element from this array.
    return this[Math.floor(Math.random() * this.length)];
  };

  Array.prototype.last = function() {
    //! Retrieve this array's last element.
    return this[this.length - 1];
  };

  String.prototype.tokenize = function() {
    //! Split this string at the first occurrence of whitespace.
    return this.replace(/\s+/, '\x01').split('\x01');
  };

  //! ========================================
  //! Finally, log Haruka in.
  client.login(Haruka.config.token);

}).call(this);
