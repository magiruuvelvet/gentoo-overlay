# Notes

based on https://github.com/Zren/material-decoration

- Removed dbus menu support, as I already have the menu bar integrated into the plasmashell panel.
  (There are also compiler errors I don't want to bother fixing)
- I just needed an replacement for my old `aurorae` based window decoration theme, as the aurorae engine
  seems to have problems with mixed DPI multi-monitor environments. The window decoration was extremely
  pixelated and unreadable on unscaled (1.0) screens. Maybe it's just my own aurorae decoration theme
  which was broken, but other themes were broken too.
- I didn't like my `aurorae` decoration theme anymore. It was time for something fresh (and native C++,
  instead of dealing with a bunch of SVG files).
