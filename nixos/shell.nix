{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nox 
    vim neovim git
    zsh zsh-completions
    python python3
    python27Packages.pip
    python37Packages.pip
  ];
}
