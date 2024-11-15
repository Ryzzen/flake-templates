{
  description = "Quick and dirty FHS for ESP-IDF developpment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    esp-idf = {
      url = "github:espressif/esp-idf/master";
      flake = false;
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      esp-idf,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      fhs = pkgs.buildFHSUserEnv {
        name = "fhs-shell";
        targetPkgs = pkgs: [
          pkgs.gcc
          pkgs.libtool
          pkgs.git
          pkgs.wget
          pkgs.gnumake
          pkgs.flex
          pkgs.bison
          pkgs.gperf
          pkgs.pkg-config
          pkgs.cmake
          pkgs.ncurses5
          pkgs.ninja
          pkgs.udev
          pkgs.libusb1
          pkgs.zlib
          (pkgs.python3.withPackages (
            p: with p; [
              pip
              virtualenv
            ]
          ))
        ];
        runScript = "
          bash ${esp-idf}/install.sh all && . ${esp-idf}/export.sh && bash;
        ";
      };
    in
    {
      devShells.${system}.default = fhs.env;
    };
}
