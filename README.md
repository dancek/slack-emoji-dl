# slack-emoji-dl

Downloader for custom emoji in your Slack instance.

## Usage

1. Get an OAuth token with the `emoji:read` permission (eg. create an app with the manifest below)
2. With that token, run `./dump-emoji.sh xoxb-MY_TOKEN`

Custom emojis are saved in the `data/` directory. To see changes since the last time, run `./changes.sh`.

## App manifest

```
display_information:
  name: emoji backup bot
features:
  bot_user:
    display_name: emoji backup bot
    always_online: false
oauth_config:
  scopes:
    bot:
      - emoji:read
settings:
  org_deploy_enabled: false
  socket_mode_enabled: false
  token_rotation_enabled: false
```

## Copyright

Copyright Hannu Hartikainen 2022-2023. MIT License.
