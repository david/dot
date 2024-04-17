Dev Desktop Plan
================

## Sizes depending on active monitor

- [ ] Fonts
- [ ] Gaps
- [ ] Widgets

## Speed up ws.nu actions

This likely means removing the code that is in `export-env` and moving it to
a dedicated command.

## Widget visibility

Widgets should not cover up content as they currently do on some workspaces.

Possible ways to fix the issue:

- **Unpin the widget windows before switching to those workspaces.**
  To make this always work, I'd need to listen to workspace switching events.

- ~~Always keep the wm gap below the widgets.~~
  I really want some windows to span the entire screen

- **Make the widget windows invisible.**
  I am unable to make it work on Hyprland, though.

## PR Review

- [ ] List commits present only in the current branch

  `git log --online master..HEAD`

- [ ] Show the contents of each commit when walking through them
- [ ] Do the above in a dedicated workspace
- [ ] Make it possible to only see the changes for a given file (?)
- [ ] Make it possible to change the number of lines of context
- [ ] Make it possible to jump to the file related to the changes we're currently seeing

## Git reapply cherry picks

```
hint: use --reapply-cherry-picks to include skipped commits
hint: Disable this message with "git config advice.skippedCherryPicks false"
```
