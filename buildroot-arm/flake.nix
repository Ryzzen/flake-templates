{
  description = "FHS shell for Buildroot ARM development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      fhs = pkgs.buildFHSEnv {
        name = "buildroot-arm-shell";
        # Host requirements per the Buildroot manual:
        # https://buildroot.org/downloads/manual/manual.html#requirement
        targetPkgs =
          pkgs: with pkgs; [
            # mandatory host deps
            gcc
            binutils
            gnumake
            perl
            which
            gnused
            patch
            gzip
            bzip2
            gnutar
            cpio
            unzip
            rsync
            file
            bc
            findutils
            diffutils
            gawk

            # commonly required by package builds inside buildroot
            python3
            bison
            flex
            wget
            git

            # for `make menuconfig`
            ncurses

            # for running the resulting ARM image
            # e.g. qemu-system-arm -M vexpress-a9 -kernel output/images/zImage ...
            qemu
          ];
        runScript = "bash";
      };
    in
    {
      devShells.${system}.default = fhs.env;
    };
}
