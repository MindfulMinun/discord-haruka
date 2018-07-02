# Notes

Some reminders on how to do stuff.

### Compile Coffeescript
```bash
#! In this directory
$ coffee -o dist/ -cw src/
```

### Copy files from local to Server
```bash
#! In Haruka: Clear everything in Haruka
$ rm -rf ~
$ ls # Should return a newline
$ logout
```
```bash
#! In local: Copy files from local to server
$ scp -r ~/path/to/discord-haruka/ Haruka@127.0.0.1:~
```

### Run Haruka as a daemon
```bash
#! In Haruka
$ npm install
$ pm2 start dist/main.js
#! You can safely close the terminal window
```

### Kill Haruka's daemon
```bash
#! In Haruka: kills all pm2 daemons
$ pm2 stop
```

### Restart daemon
```bash
$ pm2 restart
```
