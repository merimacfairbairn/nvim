{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env.NVIM_APPNAME = "nvim";

  languages = {
    lua.enable = true;
  };

  # https://devenv.sh/packages/
  packages = with pkgs; [
    neovim
    stylua
    fzf
    ripgrep
  ];

  git-hooks.hooks = {
    stylua.enable = true;
  };

  scripts.v.exec = ''
    NVIM_APPNAME=nvim nvim $@
  '';

  enterShell = ''
    git --version
  '';
}
