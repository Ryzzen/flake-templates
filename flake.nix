{
  description = "Ryzzen's flake templates";

  outputs =
    { self, ... }:
    {
      templates = {
        pwn = {
          path = ./pwn;
        };
        zephyr-rtos = {
          path = ./zephyr-rtos;
        };
        esp-idf = {
          path = ./esp-idf;
        };
        c-cpp = {
          path = ./c-cpp;
        };

      };
    };
}
