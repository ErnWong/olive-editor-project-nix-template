# My personal templates to use the [Olive video editor](https://github.com/olive-editor/olive) on NixOS

[!WARNING]
I haven't tested whether this template works well with my video editing workflow yet.

Reasons for this template's existence:

- Pinned exact version of the editor used that will be compatible with the project files. Since Olive is under active development and there is a big rewrite upcoming, it seems like a good idea to have the exact version used documented when I go archive a video project.
- Some local fixes, such as `wrapGAppsHook3` to fix a "org.gtk.Settings.FileChooser" related error, although this should probably be upstreamed to nixpkgs (although I wonder why this isn't already handled by the Qt wrap?)
- Use the decompressed xml file format so it's slightly more git friendly (but it's probably still wise to avoid doomg anything crazy like branching/merging).
- The latest nixpkgs' Olive builds are broken. This template pins it down to a known working version.
- Here we're doing something a bit exotic: We're using proot to mount the project files and directory into a statically defined folder in the root directory, so that the project files does not refer to filepaths that are specific to the machine, hoping that this will make the video projects more portable and easily archive in the future. Unfortunately it does break some features, like "Reveal in File Manager" won't work as the virtual file paths won't exist outside of the Olive video editor process.

Feel free to use this template if it suits you. I'm a bit unsure how to properly license templates like these.

Make sure to put your assets into `./assets/`
- you will then be able to access them within Olive editor in `/project/assets` where `/project` is virtual folder mounted into the user-space chroot (proot) when running Olive.
- Git will also ignore those assets - be careful as they won't be version controlled! Archive and back them up separately. We assume that the assets are effectively immutable and don't need version controlling.

