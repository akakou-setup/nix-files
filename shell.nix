{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nox 
    vim neovim git
    zsh zsh-completions
    python python38Full
    python27Packages.pip
    python38Packages.pip
    pipenv
    nodejs yarn 
  ];
}
