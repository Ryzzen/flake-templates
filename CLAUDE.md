# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A collection of Nix flake templates exposed through the root `flake.nix`. Each subdirectory is a self-contained template that ships its own `flake.nix` (and any companion files like `Makefile`, `.clangd`, Docker setup, Zephyr `app/`, etc.). Consumers pull a template with:

```bash
nix flake init -t github:Ryzzen/flake-templates#<template-name>
```

## Adding a new template

1. Create a new top-level directory containing a `flake.nix` (plus any scaffolding files the template needs).
2. Register it in the root `flake.nix` under `outputs.templates`:
   ```nix
   <name> = { path = ./<name>; };
   ```
   The attribute name is what users put after `#` in `nix flake init -t ...#<name>`. There is no automatic discovery — an unregistered subdirectory will silently not be usable as a template.

## Per-template shell strategies (each template picks one deliberately)

The four existing templates demonstrate the four shell-construction patterns used in this repo. When editing or adding templates, follow the matching pattern rather than mixing them:

- **`c-cpp`** — `flake-utils.eachDefaultSystem` + `mkShell.override { stdenv = clangStdenv; }`. Multi-system, pure Nix shell. Ships a `mk` shell helper (built with `writeShellScriptBin`), a generic `Makefile`, and a `.clangd` config. Use this pattern for templates whose toolchain is fully available in nixpkgs.
- **`esp-idf`** — `buildFHSUserEnv` whose `runScript` invokes the upstream `install.sh` + `export.sh` from the ESP-IDF source pulled in as a non-flake input (`flake = false` with submodules). Use this pattern for vendor SDKs that hard-code FHS paths or run their own bootstrap.
- **`zephyr-rtos`** — Uses the `zephyr-nix` overlay; `x86_64-linux` only. The SDK is narrowed with `zephyr.sdk.override { targets = [...]; }` — when changing the target board, update both the `targets` list in `flake.nix` and `BOARD` in `app/CMakeLists.txt`. The `app/` directory is the west workspace seed (`west.yml`, `prj.conf`, `CMakeLists.txt`).
- **`pwn`** — Manual `forEachSupportedSystem` over four systems (x86_64/aarch64 × linux/darwin). Pulls a non-flake input `ryzzen-pkgs` (github:Ryzzen/pkgsnix) for the custom `bata24-gef` debugger that overrides `pwntools`'s default. The companion `Dockerfile` / `docker-compose.yml` / `.env` provide an Ubuntu target rootfs for cross-arch exploitation (controlled by `ARCH` in `.env`); the Nix shell is the *host* analysis env, the container is the *target*.

## Validating a template change

```bash
# Inside a template directory:
nix flake check          # evaluates the flake
nix develop              # enters the dev shell

# From an empty scratch dir, end-to-end test:
nix flake init -t /home/ryzzen/NixOS/flake-templates#<name>
nix develop
```

Pin `nixpkgs` refs are intentionally not uniform across templates (`nixos-24.05` for zephyr, `nixos-unstable` for esp-idf/pwn, `nixpkgs-unstable` for c-cpp) — match what the upstream toolchain needs rather than normalizing.
