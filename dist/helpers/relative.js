// Generated by CoffeeScript 2.3.1
/*
 * Passing a date returns a string with the time relative to now.
 */
var relative;

module.exports = relative = function(date) {
  var M, d, h, m, s, secs, y;
  if (date == null) {
    date = new Date;
  }
  if (!(date instanceof Date)) {
    date = new Date(date);
  }
  if (Number.isNaN(date)) {
    date = new Date;
  }
  secs = ((+(new Date)) - (+date)) / 1000;
  s = Math.abs(Math.round(secs % 60));
  m = Math.abs(Math.round((secs % 3600) / 60));
  h = Math.abs(Math.round((secs % 86400) / 3600));
  d = Math.abs(Math.round((secs % (30.5 * 86400)) / 86400));
  M = Math.abs(Math.round((secs % (365 * 86400)) / (30.5 * 86400)));
  y = Math.abs(Math.round(secs / (365 * 86400)));
  if (Math.abs(secs) === secs) {
    switch (false) {
      case !(secs < 15):
        return "Just now";
      case !(secs < 45):
        return `${s} seconds ago`;
      case !(secs < 90):
        return "A minute ago";
      case !(secs < 60 * 45):
        return `${m} minutes ago`;
      case !(secs < 60 * 90):
        return "An hour ago";
      case !(secs < 22 * 3600):
        return `${h} hours ago`;
      case !(secs < 36 * 3600):
        return "Yesterday";
      case !(secs < 26 * 86400):
        return `${d} days ago`;
      case !(secs < 45 * 86400):
        return "A month ago";
      case !(secs < 320 * 86400):
        return `${M} months ago`;
      case !(secs < 548 * 86400):
        return "a year ago";
      default:
        return `${y} years ago`;
    }
  } else {
    secs = Math.abs(secs);
    switch (false) {
      case !(secs < 15):
        return "Right now";
      case !(secs < 45):
        return `In ${s} seconds`;
      case !(secs < 90):
        return "In one minute";
      case !(secs < 60 * 45):
        return `In ${m} minutes`;
      case !(secs < 60 * 90):
        return "In an hour";
      case !(secs < 22 * 3600):
        return `In ${h} hours`;
      case !(secs < 36 * 3600):
        return "Tomorrow";
      case !(secs < 26 * 86400):
        return `In ${d} days`;
      case !(secs < 45 * 86400):
        return "In one month";
      case !(secs < 320 * 86400):
        return `In ${M} months`;
      case !(secs < 548 * 86400):
        return "In one year";
      default:
        return `In ${y} years`;
    }
  }
};

/*
    If the time takes place in the past...
        Range                           Output
        ------------------------------  ------------------------------
        -5 sec to 14 sec                Just now
        15 sec to 44 sec                _ seconds ago
        45 sec to 89 sec                A minute ago
        90 sec to 44 mins               _ minutes ago
        45 mins to 89 mins              An hour ago
        90 mins to 21h                  _ hours ago
        22 hrs to 35 hrs                Yesterday
        36 hrs to 24 days               _ days ago
        26 days to 45 days              a month ago
        45 days to 319 days             _ months ago
        320 days to 548 days            a year ago
        548 days+                       _ years ago

    If the time takes place in the future...
        Range                           Output
        ------------------------------  ------------------------------
        -5 sec to 14 sec                Right now
        15 sec to 44 sec                In _ seconds
        45 sec to 89 sec                In one minute
        90 sec to 44 mins               In _ minutes
        45 mins to 89 mins              In one hour
        90 mins to 21h                  In _ hours
        22 hrs to 35 hrs                Tomorrow
        36 hrs to 24 days               In _ days
        26 days to 45 days              In one month
        45 days to 319 days             In _ months
        320 days to 548 days            In one year
        548 days+                       In _ years
*/