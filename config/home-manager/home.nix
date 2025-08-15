{ config, pkgs, ... }:

let
  # Robust WSL detection using multiple fallback methods
  isWSL = 
    let
      # Primary method: check /proc/sys/kernel/osrelease for Microsoft WSL signatures
      # Expected formats: "6.6.87.2-microsoft-standard-WSL2", "5.4.0-Microsoft", etc.
      checkOsRelease = 
        if builtins.pathExists /proc/sys/kernel/osrelease
        then 
          let content = builtins.readFile /proc/sys/kernel/osrelease;
          in (builtins.match ".*[Mm]icrosoft.*" content != null) ||
             (builtins.match ".*[Ww][Ss][Ll][0-9]*.*" content != null)
        else false;
      
      # Fallback method: check /proc/version for WSL indicators
      checkProcVersion = 
        if builtins.pathExists /proc/version
        then builtins.match ".*(microsoft|wsl|WSL|Microsoft).*" (builtins.readFile /proc/version) != null
        else false;
    in
    checkOsRelease || checkProcVersion;
in
{
  # Core system configuration
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "dhs";
    homeDirectory = "/home/dhs";
    stateVersion = "25.11";
  };

  # Package configuration: common packages for all environments
  home.packages = with pkgs; 
    let
      # Development tools
      devTools = [
        android-tools
        ansible
        asdf-vm
        git
        gh
        jdk
        lazygit
        lua51Packages.luarocks-nix
        mdbook
        rustup
        sdkmanager
      ];

      # Command line utilities
      cliTools = [
        fasd
        fd
        fzf
        htop-vim
        neofetch
        neovim
        pandoc
        ripgrep
        silver-searcher
        superfile
        tmux
        tree
        unzip
        zip
      ];

      # System and runtime tools
      systemTools = [
        flutter
        home-manager
        virtualgl
        zimfw
      ];

      # GUI applications (only for non-WSL environments)
      guiApps = [
        anydesk
        arandr
        beeper
        blueman
        clipmenu
        dunst
        google-chrome
        keymapper
        redshift
        rofi
        sioyek
        termius
        vscode
        # wezterm
        # wpsoffice
        zoom-us
      ];

      # Combine all package lists
      commonPackages = devTools ++ cliTools ++ systemTools;
    in
    commonPackages ++ (if !isWSL then guiApps else []);

  # Zim framework configuration
  home.file.".zimrc".text = ''
    # Core Zim modules
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
    
    # Completions
    zmodule zsh-users/zsh-completions --fpath src
    zmodule completion

    # Enhanced zsh features
    zmodule zsh-users/zsh-syntax-highlighting
    zmodule zsh-users/zsh-history-substring-search
    zmodule zsh-users/zsh-autosuggestions
  '';

  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    initContent = ''
      # Use emacs keybindings
      bindkey -e

      # Initialize Zim framework
      ZIM_HOME=$HOME/.zim
      if [ -e $HOME/.nix-profile/zimfw.zsh ]; then 
        . $HOME/.nix-profile/zimfw.zsh init
      fi

      # Configure PATH
      export PATH="$HOME/.config/composer/vendor/bin:$HOME/bin:$HOME/.asdf/shims:$PATH"

      # Initialize starship prompt
      eval "$(starship init zsh)"
      
      # Source nix profile if available
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      # WSL-specific configuration
      ${if isWSL then ''
      # Configure ADB for WSL - connect to host Windows ADB server
      export ADB_SERVER_SOCKET=tcp:$(ip route show | grep -i default | awk '{ print $3}'):5037
      '' else ""}
      
      # Set Chrome executable path
      export CHROME_EXECUTABLE=google-chrome-stable
    '';
  };
}
