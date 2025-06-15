{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nox xonsh any-nix-shell
    vim neovim git gh
    steam-run
  ];
}
