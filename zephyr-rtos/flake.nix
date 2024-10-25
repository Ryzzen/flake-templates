{
  description = "A very basic Zephyr flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    zephyr-nix.url = "github:adisbladis/zephyr-nix";
    zephyr-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      zephyr-nix,
      ...
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      zephyr = zephyr-nix.packages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = [
          (zephyr.sdk.override {
            targets = [
              "xtensa-espressif_esp32_zephyr-elf"
            ];
          })
          zephyr.pythonEnv
          # Use zephyr.hosttools-nix to use nixpkgs built tooling instead of official Zephyr binaries
          zephyr.hosttools
          pkgs.cmake
          pkgs.ninja
        ];
      };
    };
}
