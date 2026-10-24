{
  description = "Neovim configuration with LSP dependencies";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    wrappers = {
      url = "github:nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem = {pkgs, ...}: let
        runtimePkgs = with pkgs; [
          # LSPs
          lua-language-server
          vscode-langservers-extracted
          emmet-language-server
          svelte-language-server
          rust-analyzer
          typescript-language-server
          tailwindcss-language-server
          python313Packages.python-lsp-server
          nixd

          # Formatters and related tools
          ast-grep
          prettier
          black
          alejandra
          rustfmt
          stylua

          # General dependencies
          lua5_1
          tree-sitter
          ripgrep
          gcc
          cargo
          fzf
          gnumake
          luarocks
        ];

        mkNvim = runtimePkgs:
          inputs.wrappers.wrappers.neovim.wrap {
            inherit pkgs runtimePkgs;

            env = {
              CONFIG_ROOT = ./.;
              NVIM_APPNAME = "nvim-merimac-remote";
            };

            settings.config_directory = ./.;
          };
      in {
        packages = {
          default = mkNvim runtimePkgs;

          minimal = mkNvim (with pkgs; [
            lua5_1
            tree-sitter
            ripgrep
            gcc
            fzf
            luarocks
          ]);
        };
      };
    };
}
