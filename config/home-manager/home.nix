{ config, pkgs, ...}:

let
  isWSL = builtins.match "Microsoft" (builtins.readFile /proc/sys/kernel/osrelease) != null;
in
{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "dhs";
    homeDirectory = "/home/dhs";
    stateVersion = "25.11";
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
    gh
    google-chrome
    home-manager
    htop-vim
    jdk
    lazygit
    lua51Packages.luarocks-nix
    mdbook
    neofetch
    neovim
    pandoc
    ripgrep
    rustup
    superfile
    sdkmanager
    silver-searcher
    tmux
    tree
    unzip
    virtualgl
    zimfw
    zip
  ] ++ (if !isWSL then with pkgs; [ 
    anydesk
    arandr
    beeper
    blueman
    clipmenu
    dunst
    keymapper
    redshift
    rofi 
    sioyek
    termius
    vscode
    # wezterm
    # wpsoffice
    zoom-us
  ] else []);

  home.file.".zimrc".text = ''
    zmodule environment
    zmodule git
    zmodule input
    zmodule termtitle
    zmodule utility
    zmodule duration-info
    zmodule git-info
    zmodule asciiship
    zmodule fasd
    zmodule fzf
    zmodule zsh-users/zsh-completions --fpath src
    zmodule completion

    zmodule zsh-users/zsh-syntax-highlighting
    zmodule zsh-users/zsh-history-substring-search
    zmodule zsh-users/zsh-autosuggestions
  '';

  programs.zsh = {
    enable = true;
    initContent = ''
      bindkey -e

      ZIM_HOME=$HOME/.zim
      if [ -e $HOME/.nix-profile/zimfw.zsh ]; then . $HOME/.nix-profile/zimfw.zsh init; fi
      export PATH="$HOME/.config/composer/vendor/bin:$HOME/bin:$HOME/.asdf/shims:$PATH"

      eval "$(starship init zsh)"
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh; 
      fi
      if grep -iqE "(microsoft|wsl)" /proc/version; then
        export ADB_SERVER_SOCKET=tcp:$(ip route show | grep -i default | awk '{ print $3}'):5037
      fi
      export CHROME_EXECUTABLE=google-chrome-stable
    '';
  };
}
