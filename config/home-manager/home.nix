{ config, pkgs, ...}:

{
  home.username = "dhs";
  home.homeDirectory = "/home/dhs";

  home.packages = with pkgs; [
    asdf-vm
    fasd
    fd
    fzf
    git
    home-manager
    htop
    lazygit
    lua51Packages.luarocks-nix
    neofetch
    neovim
    ripgrep
    rustup
    silver-searcher
    tmux
    tree
  ];

  home.stateVersion = "24.11";
}
