{
  description = "A nix shell for vulnerability research on Linux binaries";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ryzzen-pkgs = {
      url = "github:Ryzzen/pkgsnix/main";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ryzzen-pkgs,
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f: nixpkgs.lib.genAttrs supportedSystems (system: f { pkgs = import nixpkgs { inherit system; }; });
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              (python311.withPackages (
                ps: with ps; [
                  (ps.pwntools.override { debugger = pkgs.callPackage "${ryzzen-pkgs}/bata24-gef" { }; })
                  ropper
                ]
              ))
              gdb
              one_gadget
              checksec
              patchelf
            ];
          };
        }
      );
    };
}
