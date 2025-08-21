{ config, pkgs, ... }:

let
  # Robust WSL detection using multiple fallback methods
  isWSL = 
    let
      # Primary method: check /proc/sys/kernel/osrelease for Microsoft WSL signatures
      checkOsRelease = 
        if builtins.pathExists /proc/sys/kernel/osrelease
        then 
          let 
            content = builtins.readFile /proc/sys/kernel/osrelease;
            # Remove any trailing whitespace/newlines that might interfere
            cleanContent = builtins.replaceStrings ["\n" "\r"] ["" ""] content;
          in 
            # Check for various WSL signatures (case-insensitive approach)
            (builtins.match ".*[Mm]icrosoft.*" cleanContent != null) ||
            (builtins.match ".*[Ww][Ss][Ll].*" cleanContent != null) ||
            (builtins.match ".*microsoft.*" cleanContent != null) ||
            (builtins.match ".*WSL.*" cleanContent != null)
        else false;
      
      # Fallback method: check /proc/version
      checkProcVersion = 
        if builtins.pathExists /proc/version
        then
          let 
            content = builtins.readFile /proc/version;
            cleanContent = builtins.replaceStrings ["\n" "\r"] ["" ""] content;
          in
            (builtins.match ".*[Mm]icrosoft.*" cleanContent != null) ||
            (builtins.match ".*[Ww][Ss][Ll].*" cleanContent != null)
        else false;
      
      # Additional fallback: check for WSL environment variable
      checkWSLEnv = builtins.getEnv "WSL_DISTRO_NAME" != "";
    in
    checkOsRelease || checkProcVersion || checkWSLEnv;
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
        starship
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

      # ------------------
      # Initialize modules
      # ------------------

      ZIM_HOME=$HOME/.zim
      # Download zimfw plugin manager if missing.
      if [[ ! -e $ZIM_HOME/zimfw.zsh ]]; then
        curl -fsSL --create-dirs -o $ZIM_HOME/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
      fi
      # Initialize modules.
      source $ZIM_HOME/init.zsh

      # Configure PATH
      export PATH="$HOME/.config/composer/vendor/bin:$HOME/bin:$HOME/.asdf/shims:$PATH"

      # Initialize starship prompt
      eval "$(starship init zsh)"
      
      # Source nix profile if available
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/nix.sh
      fi

      # Set Chrome executable path
      export CHROME_EXECUTABLE=google-chrome-stable

      # WSL-specific configuration
      ${if isWSL then ''
      # Configure ADB for WSL - connect to host Windows ADB server
      export ADB_SERVER_SOCKET=tcp:$(ip route show | grep -i default | awk '{ print $3}'):5037
      '' else ""}
    '';
  };
}
