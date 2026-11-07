# Roblox Auto Boost Script

Roblox Auto Boost is a server-side Roblox script that automatically increases a character's movement speed when the character starts moving. This Roblox script includes configurable boost speed, duration, cooldown interval, movement threshold, character cleanup, and server-controlled speed restoration.

## Install

1. Open your Roblox place in Roblox Studio.
2. In the Explorer, open `ServerScriptService`.
3. Create a normal `Script` named `AutoBoost`.
4. Open `ServerScriptService/AutoBoost.server.lua` from this project.
5. Copy the script contents into the new `AutoBoost` Script.
6. Press Play in Roblox Studio to test the automatic boost.

## Use

1. Move a character in the Roblox game.
2. When the movement speed exceeds the configured threshold, the script starts a boost.
3. During the boost, the character's `Humanoid.WalkSpeed` is changed to `BOOST_SPEED`.
4. After `BOOST_DURATION` seconds, the character's original walk speed is restored.
5. A new boost cannot start until `BOOST_INTERVAL` seconds have passed.
6. To customize the behavior, edit these values near the top of the script:

```lua
local BOOST_SPEED = 28
local NORMAL_SPEED = 16
local BOOST_DURATION = 3
local BOOST_INTERVAL = 10
local MOVEMENT_THRESHOLD = 0.1
```

`BOOST_SPEED` controls movement speed during the boost.

`NORMAL_SPEED` is the fallback speed used when the original character speed is unavailable.

`BOOST_DURATION` controls how long each boost lasts, in seconds.

`BOOST_INTERVAL` controls the minimum time between automatic boost triggers, in seconds.

`MOVEMENT_THRESHOLD` controls the minimum reported movement speed required to trigger a boost.

The script runs on the server and restores each character's original walk speed after the boost ends or when the character is removed.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/d1ac6483-0210-487e-9710-b237a11d1b52?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=d1ac6483-0210-487e-9710-b237a11d1b52
