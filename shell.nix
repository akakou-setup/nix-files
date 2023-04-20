{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nox xonsh
    vim neovim git hub
    zsh zsh-completions
    python python38Full
    python27Packages.pip
    python38Packages.pip
    pipenv
    nodejs yarn 
    python38Packages.ipython
  ];
}
