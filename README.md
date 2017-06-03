# pigeon

Pigeon is a [Discord](https://discordapp.com/) bot that will email you chat logs.

```
[2017-06-03 03:51 | Y32 #lunes-cave] <z64> sending
[2017-06-03 03:51 | Y32 #lunes-cave] <z64> you
[2017-06-03 03:51 | Y32 #lunes-cave] <z64> mail!
[2017-06-03 03:52 | Y32 #lunes-cave] <z64> [attachments: https://cdn.discordapp.com/attachments/246283902652645376/320409267943374848/oc.png]
```

## Prerequisites

- Ruby 2.4+ (earlier versions may work, untested)
- `bundler` installed (`gem install bundler`)
- `rake` installed (`gem install rake`)
- If on Windows, you will need the Ruby [DevKit](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit#quick-start).

## Configuration

1. **Install gems.** `rake install` should take care of this for you.

2. **Create a file called `config.yml`** in the same folder as this `README.md` with the following keys:

key | description | type
--|--|--
`token` | Your user token. | `String`
`interval` | Interval at which to dispatch emails. Pigeon uses a `Rufus::Scheduler#every` cron. **[Documentation](http://www.rubydoc.info/gems/rufus-scheduler#scheduling)** | `String`
`gmail_username` | Your gmail username. | `String`
`gmail_password` | Your gmail password. | `String`
`servers` | An array of server IDs you want logs from. There must be at least one entry. | `Array<Integer, String>`

#### `config.yml` Example
```yaml
---
token: YOUR TOKEN

interval: '5m'

gmail_username: my_bots_email
gmail_password: password

deliver_to: my_real_email@gmail.com

servers:
  - 225375815087554563
```

> **Note about GMail accounts! Do not use your personal email account.** Create a dummy address for your bot, and be sure to enable "Allow access for less secure apps" [here](https://myaccount.google.com/lesssecureapps), otherwise this won't work.

## Running Pigeon

Simply run `rake` at your terminal.
## Contributors

- [z64](https://github.com/z64) Zac Nowicki - creator, maintainer
