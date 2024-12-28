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
        zephyr-rtos = {
          path = ./zephyr-rtos;
          description = "Minimal nix shell for zephyr-rtos developpment";
        };
        esp-idf = {
          path = ./esp-idf;
          description = "Quick and dirty FHS for ESP-IDF developpment";
        };
        c-cpp = {
          path = ./c-cpp;
          description = "C/C++ Developpment environement";
        };

      };
    };
}
