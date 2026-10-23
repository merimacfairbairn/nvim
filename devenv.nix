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
  ];

  git-hooks.hooks = {
    stylua.enable = true;
  };

  enterShell = ''
    git --version # Use packages
  '';
}
