# Adding a script

1. Put the `.bat` in `scripts/<category>/`. Use an existing category folder, or add a new one and a matching entry under `categories` in `catalog.json`.
2. Add an entry to `catalog.json`:
   ```json
   {
     "file": "display/example.bat",
     "title": "Example",
     "description": "One sentence on what it does.",
     "admin": false,
     "requires": [],
     "note": "Anything to edit first or watch out for."
   }
   ```
   `admin`, `requires` and `note` are optional. `requires` lists helper files (such as a `.ps1`) in `scripts/` that must sit beside the script.
3. Run `node tools/build.mjs`, then commit the regenerated `docs/index.html` and `README.md` along with your change. The build refuses to run if a script isn't in the catalog, a catalog entry has no file, or a helper isn't referenced.

## Conventions

- Start with `@echo off` and a `rem` line saying what the script does. People read these before running them.
- Keep it to built-in Windows tools (`reg`, `netsh`, `powercfg`, PowerShell). No downloads, no network calls, no third-party executables.
- Scripts that need admin should re-launch themselves through UAC, like [`wifi-off.bat`](scripts/network/wifi-off.bat), and set `"admin": true`.
- Put things a user may need to change (adapter names, device names, app lists) in a `set` line at the top.
- Use ASCII only, and keep CRLF line endings. `.gitattributes` enforces this on commit; if your editor fights it, check that it isn't converting to LF.
- Destructive actions (force-closing apps, deleting files) must be obvious from the script's name and description, and the catalog `note` should say what's lost.
