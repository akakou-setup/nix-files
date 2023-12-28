{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nox xonsh
    vim neovim git hub
    zsh zsh-completions
    python 
    pipenv
    nodejs yarn 
  ];
}
