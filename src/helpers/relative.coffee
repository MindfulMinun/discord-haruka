###
 * Passing a date returns a string with the time relative to now.
###
module.exports = relative = (date) ->
    if not date?                  then date = new Date
    if not (date instanceof Date) then date = new Date(date)
    if Number.isNaN date          then date = new Date

    secs = ((+new Date) - (+date)) / 1000
    s = Math.abs Math.round(secs % 60)
    m = Math.abs Math.round((secs % 3600) / 60)
    h = Math.abs Math.round((secs % 86400) / 3600)
    d = Math.abs Math.round((secs % (30.5 * 86400)) / 86400)
    M = Math.abs Math.round((secs % (365 * 86400)) / (30.5 * 86400))
    y = Math.abs Math.round(secs / (365 * 86400))



    if Math.abs(secs) is secs
        switch
            when secs < 15            then "Just now"
            when secs < 45            then "#{s} seconds ago"
            when secs < 90            then "A minute ago"
            when secs < 60 * 45       then "#{m} minutes ago"
            when secs < 60 * 90       then "An hour ago"
            when secs < 22 * 3600     then "#{h} hours ago"
            when secs < 36 * 3600     then "Yesterday"
            when secs < 26 * 86400    then "#{d} days ago"
            when secs < 45 * 86400    then "A month ago"
            when secs < 320 * 86400   then "#{M} months ago"
            when secs < 548 * 86400   then "a year ago"
            else                           "#{y} years ago"
    else
        secs = Math.abs(secs)
        switch
            when secs < 15            then "Right now"
            when secs < 45            then "In #{s} seconds"
            when secs < 90            then "In one minute"
            when secs < 60 * 45       then "In #{m} minutes"
            when secs < 60 * 90       then "In an hour"
            when secs < 22 * 3600     then "In #{h} hours"
            when secs < 36 * 3600     then "Tomorrow"
            when secs < 26 * 86400    then "In #{d} days"
            when secs < 45 * 86400    then "In one month"
            when secs < 320 * 86400   then "In #{M} months"
            when secs < 548 * 86400   then "In one year"
            else                           "In #{y} years"

###
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
###
