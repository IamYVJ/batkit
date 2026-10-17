# batkit

One-click Windows `.bat` scripts for everyday tasks: turn the monitors off, switch audio devices, flush DNS, start your workday. Each script is a small, readable text file you can double-click.

**Browse and download:** open [`docs/index.html`](docs/index.html) in any browser. It's a single offline page that lists every script, shows its source, and downloads it (or everything as a zip). If you host the repo on GitHub Pages (Settings > Pages > Deploy from branch > `main` / `docs`), it's also a live website.

## Using a script

1. Download it from the site, or grab it from `scripts/` in this repo.
2. Read it. They're short, and the first lines say what they do.
3. Double-click to run. Scripts marked **Needs admin** ask for permission via Windows' UAC prompt.

Some scripts ship with a `.ps1` helper (Night light, audio switching). Keep the helper in the same folder as the script. The site bundles them together as a zip.

Windows may show a SmartScreen or "may harm your device" warning for any downloaded script. That's normal; it's the reason to read the script first.

## Scripts

<!-- scripts:start -->

### Display

Monitors, brightness, themes and projector modes.

| Script | What it does |
|---|---|
| [`monitoroff.bat`](scripts/display/monitoroff.bat) | Turns every connected monitor off until you move the mouse or press a key. Nothing is locked or closed. |
| [`monitoroff-lock.bat`](scripts/display/monitoroff-lock.bat) | Locks the PC, then switches the monitors off. Waking them shows the lock screen. |
| [`brightness-low.bat`](scripts/display/brightness-low.bat) | Dims the screen to 20% brightness. |
| [`brightness-high.bat`](scripts/display/brightness-high.bat) | Sets the screen to full brightness. |
| [`night-light-toggle.bat`](scripts/display/night-light-toggle.bat) | Turns Night light (warm screen colours) on or off. |
| [`dark-mode-toggle.bat`](scripts/display/dark-mode-toggle.bat) | Switches Windows and apps between dark and light mode. |
| [`extend-displays.bat`](scripts/display/extend-displays.bat) | Extends the desktop across all connected displays (Win+P, Extend). |
| [`duplicate-displays.bat`](scripts/display/duplicate-displays.bat) | Shows the same image on every display (Win+P, Duplicate). |
| [`second-screen-only.bat`](scripts/display/second-screen-only.bat) | Uses only the external display (Win+P, Second screen only). |
| [`pc-screen-only.bat`](scripts/display/pc-screen-only.bat) | Uses only the main display (Win+P, PC screen only). |

### Power

Sleep, shutdown timers, power plans and staying awake.

| Script | What it does |
|---|---|
| [`sleep-now.bat`](scripts/power/sleep-now.bat) | Puts the PC to sleep right away. |
| [`hibernate-now.bat`](scripts/power/hibernate-now.bat) | Hibernates the PC right away. |
| [`restart-now.bat`](scripts/power/restart-now.bat) | Restarts the PC immediately, without a countdown. |
| [`shutdown-in-30.bat`](scripts/power/shutdown-in-30.bat) | Schedules a shutdown in 30 minutes. Handy for falling asleep to a video. |
| [`cancel-shutdown.bat`](scripts/power/cancel-shutdown.bat) | Cancels a scheduled shutdown or restart. |
| [`power-plan-performance.bat`](scripts/power/power-plan-performance.bat) | Switches to the High performance power plan. |
| [`power-plan-balanced.bat`](scripts/power/power-plan-balanced.bat) | Switches to the Balanced power plan. |
| [`power-plan-saver.bat`](scripts/power/power-plan-saver.bat) | Switches to the Power saver plan. |
| [`stay-awake.bat`](scripts/power/stay-awake.bat) | Stops the PC and screen from sleeping for as long as its window stays open. Press Enter or close the window to stop. |

### Audio

Volume, mute and choosing where sound plays.

| Script | What it does |
|---|---|
| [`mute-toggle.bat`](scripts/audio/mute-toggle.bat) | Mutes or unmutes the system volume, like the keyboard mute key. |
| [`volume-50.bat`](scripts/audio/volume-50.bat) | Sets the volume to 50%. |
| [`switch-to-headphones.bat`](scripts/audio/switch-to-headphones.bat) | Makes your headphones the default playback device. |
| [`switch-to-speakers.bat`](scripts/audio/switch-to-speakers.bat) | Makes your speakers the default playback device. |
| [`list-audio-devices.bat`](scripts/audio/list-audio-devices.bat) | Shows your active playback devices, so you know what to put in the switch scripts. |

### Network

Wi-Fi, DNS and connection fixes.

| Script | What it does |
|---|---|
| [`wifi-off.bat`](scripts/network/wifi-off.bat) | Turns Wi-Fi off by disabling the adapter. **Needs admin.** |
| [`wifi-on.bat`](scripts/network/wifi-on.bat) | Turns Wi-Fi back on by enabling the adapter. **Needs admin.** |
| [`flush-dns.bat`](scripts/network/flush-dns.bat) | Clears the DNS cache. Often fixes a site that won't load after it moved servers. |
| [`network-reset.bat`](scripts/network/network-reset.bat) | Releases and renews your IP address, flushes DNS and resets Winsock. **Needs admin.** |
| [`show-wifi-password.bat`](scripts/network/show-wifi-password.bat) | Shows the saved password of the Wi-Fi network you're connected to. **Needs admin.** |

### Cleanup

Quick fixes for a cluttered or frozen desktop.

| Script | What it does |
|---|---|
| [`clear-temp.bat`](scripts/cleanup/clear-temp.bat) | Empties your user temp folder. Files that are in use are skipped. |
| [`restart-explorer.bat`](scripts/cleanup/restart-explorer.bat) | Restarts Windows Explorer. Fixes a frozen or glitchy taskbar and Start menu. |
| [`kill-browsers.bat`](scripts/cleanup/kill-browsers.bat) | Force-closes Chrome, Edge, Firefox, Brave, Opera and Vivaldi. |

### Focus

Cut distractions and start your workday.

| Script | What it does |
|---|---|
| [`focus-mode.bat`](scripts/focus/focus-mode.bat) | Closes chat apps and turns off notification banners. Undo with Focus mode off. |
| [`focus-off.bat`](scripts/focus/focus-off.bat) | Turns notification banners back on after Focus mode on. |
| [`work-start.bat`](scripts/focus/work-start.bat) | Opens your usual work apps and websites in one go. |

<!-- scripts:end -->

## Repository layout

```
scripts/<category>/   the scripts (CRLF line endings, enforced by .gitattributes)
catalog.json          title, description and flags for every script; the single source of truth
site/template.html    source of the website
docs/index.html       generated site (scripts embedded), committed so GitHub Pages can serve it
tools/build.mjs       regenerates docs/index.html and the table above from catalog.json
```

After changing a script or `catalog.json`, regenerate with `node tools/build.mjs` (Node 18+, no packages to install). CI runs it with `--check` and fails if the generated files are stale. See [CONTRIBUTING.md](CONTRIBUTING.md) to add a script.

## License

[MIT](LICENSE)
