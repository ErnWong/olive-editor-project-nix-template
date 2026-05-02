{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/master";
    nixpkgs-olive-editor.url = "github:nixos/nixpkgs/d09aec1b2769b6d64e590c0fa921cef2415529db";
  };
  outputs = inputs: let
    pkgs = import inputs.nixpkgs-stable {
      system = "x86_64-linux";
    };
    olive-editor = (import inputs.nixpkgs-olive-editor {
      system = "x86_64-linux";
      overlays = [
        (self: super: {
          olive-editor = super.olive-editor.overrideAttrs (oldAttrs: {
            nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
              self.wrapGAppsHook3
            ];
          });
        })
      ];
    }).olive-editor;
    olive-editor-wrapped = pkgs.writeShellApplication {
      name = "olive-editor-proot";
      runtimeInputs = [
        olive-editor
        pkgs.proot
        pkgs.coreutils
      ];
      text = ''
        project_dir=$(pwd)
        new_root=$(mktemp -d)
        mkdir -p "$new_root/project"
        mkdir -p "$new_root/nix/store"
        mkdir -p "$new_root/dev"
        mkdir -p "$new_root/proc"
        mkdir -p "$new_root/sys"
        mkdir -p "$new_root/tmp"
        mkdir -p "$new_root/var" # E.g. for machine-id

        ##mkdir -p "$new_root/run/gdm"
        #mkdir -p "$new_root/run/dbus"
        ##mkdir -p "$new_root/run/current-system"
        #mkdir -p "$new_root/run/user"
        ##mkdir -p "$new_root/run/blkid"
        #mkdir -p "$new_root/run/opengl-driver"
        #mkdir -p "$new_root/run/opengl-driver-32"

        mkdir -p ./olive.local
        mkdir -p ./olive.cache

        #-b /run/gdm \
        #-b /run/dbus \
        #-b /run/current-system \
        #-b /run/user \
        #-b /run/blkid \
        #-b /run/opengl-driver \
        #-b /run/opengl-driver-32 \
        proot \
          -r "$new_root" \
          -b /nix/store \
          -b /dev \
          -b /proc \
          -b /sys \
          -b /tmp \
          -b /dev/null:/run/media \
          -b /run \
          -b /var \
          -b ./olive.local:/home/ernwong/.local \
          -b ./olive.cache:/home/ernwong/.cache \
          -b "$project_dir":/project \
          -w /project \
          olive-editor /project/project.ole
      '';
    };
  in {
    packages.x86_64-linux = {
      olive-editor = olive-editor-wrapped;
    };
  };
}
