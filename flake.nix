{
  description = "Ryzzen's flake templates";

  outputs =
    { self, ... }:
    {
      templates = {
        pwn = {
          path = ./pwn;
          description = "A nix shell for vulnerability research on Linux binaries";
        };
      };
    };
}
