{ config, pkgs, ...}:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "dhs";
    homeDirectory = "/home/dhs";
    stateVersion = "24.11";
    shellAliases = {
        google-chrome = "google-chrome-stable";
    };
  };

  home.packages = with pkgs; [
    android-tools
    ansible
    asdf-vm
    fasd
    fd
    flutter
    fzf
    git
    google-chrome
    home-manager
    htop
    lazygit
    lua51Packages.luarocks-nix
    mdbook
    neofetch
    neovim
    pandoc
    ripgrep
    rustup
    sdkmanager
    silver-searcher
    tmux
    tree
    unzip
    virtualgl
    zimfw
    zip
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      bindkey -e

      ZIM_HOME=$HOME/.zim
      if [ -e $HOME/.nix-profile/zimfw.zsh ]; then . $HOME/.nix-profile/zimfw.zsh init; fi

      export PATH="$HOME/.config/composer/vendor/bin:$HOME/bin:$HOME/.asdf/shims:$PATH"
      . $HOME/.asdf/plugins/java/set-java-home.zsh
      eval "$(starship init zsh)"
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
      export ADB_SERVER_SOCKET=tcp:$(ip route show | grep -i default | awk '{ print $3}'):5037
    '';
  };
}
