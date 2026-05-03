# My personal templates to use the Olive video editor on NixOS

Reasons for this template's existence:

- Pinned exact version of the editor used that will be compatible with the project files. Since Olive is under active development and there is a big rewrite upcoming, it seems like a good idea to have the exact version used documented when I go archive a video project.
- Some local fixes, such as `wrapGAppsHook3` to fix a "org.gtk.Settings.FileChooser" related error, although this should probably be upstreamed to nixpkgs (although I wonder why this isn't already handled by the Qt wrap?)
- Use the decompressed xml file format so it's slightly more git friendly (but it's probably still wise to avoid doomg anything crazy like branching/merging).
- The latest nixpkgs' Olive builds are broken. This template pins it down to a known working version.

Feel free to use this template if it suits you. I'm a bit unsure how to properly license templates like these.

