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

  git-hooks.hooks.stylua = {
    enable = true;
    name = "stylua";
    entry = "{pkgs.stylua}/bin/stylua .";
    files = "\\.lua$";
    pass_filenames = false;
  };

  enterShell = ''
    git --version # Use packages
  '';
}
