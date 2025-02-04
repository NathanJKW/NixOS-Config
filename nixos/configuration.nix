# NixOS System Configuration
# --------------------------
# This file serves as the main configuration entry point, importing individual 
# module configurations for a modular and organized setup.
# Each module enables or configures specific features or services on the system.

{ config, pkgs, ... }:

{
  # Imports
  # -------
  # Import various system and application modules. Organized by system components, services, 
  # desktop environment, and installed packages for a structured configuration.

  imports = [
    # Core System Configuration
    ./hardware-configuration.nix                          # Hardware settings generated by NixOS
    ./modules/system/boot/systemmd.nix                    # Boot manager settings
    ./modules/system/kernel/linuxKernel_6_10.nix          # Linux kernel configuration
    ./modules/system/hardware/nvidiaDriver_555_58_02.nix  # NVIDIA driver setup
    ./modules/system/hardware/soundPulse.nix              # Sound configuration with PulseAudio
    ./modules/system/hardware/printerCUPS.nix             # Printer setup using CUPS
    ./modules/system/networking.nix                       # Network settings and configurations
    ./modules/system/userSettings.nix                     # User-specific configurations

    # Services
    ./modules/system/services/dockerNvidia.nix            # Docker with NVIDIA support
    ./modules/system/services/podmanNvidia.nix            # Podman with NVIDIA support

    # Desktop Environment
    ./modules/desktop/gnomeDesktop.nix                    # GNOME Desktop Environment setup

    # Packages
    ./modules/pkgs/cursor.nix                             # Custom cursor package
    ./modules/pkgs/git.nix                                # Git version control
    ./modules/pkgs/vscode.nix                             # Visual Studio Code IDE
    ./modules/pkgs/onlyOffice.nix                         # OnlyOffice suite
    ./modules/pkgs/thunderbird.nix                        # Thunderbird email client
    ./modules/pkgs/obsidian.nix                           # Obsidian note-taking
    ./modules/pkgs/golang.nix                             # Go programming language
  ];

  # Global Settings
  # ---------------
  # Enable unfree packages for access to non-open-source software.

  nixpkgs.config.allowUnfree = true;

  # Enable/Disable Modules
  # ----------------------
  # Control over individual modules is provided here by toggling `enable` flags.

  ## Core Modules
  myModules.systemmd.enable = true;                      # Enable Systemd boot manager
  myModules.linuxKernel_6_10.enable = true;              # Enable Linux Kernel 6.10
  myModules.nvidiaDriver_555_58_02.enable = true;        # Enable NVIDIA Driver version 555.58.02
  myModules.soundPulse.enable = true;                    # Enable PulseAudio for sound
  myModules.printerCUPS.enable = true;                   # Enable CUPS printing service
  myModules.networking.enable = true;                    # Enable networking settings
  myModules.userSettings.enable = true;                  # Enable user settings

  ## Services
  myModules.dockerNvidia.enable = false;                 # Disable Docker with NVIDIA
  myModules.podman.enable = true;                        # Enable Podman with NVIDIA support

  ## Desktop Environment
  myModules.gnomeDesktop.enable = true;                  # Enable GNOME desktop

  ## Packages
  myModules.cursor.enable = true;                        # Enable custom cursor
  myModules.vscode.enable = true;                        # Enable Visual Studio Code
  myModules.git.enable = true;                           # Enable Git
  myModules.onlyOffice.enable = true;                    # Enable OnlyOffice
  myModules.thunderbird.enable = true;                   # Enable Thunderbird
  myModules.obsidian.enable = true;                      # Enable Obsidian
  myModules.golang.enable = true;                        # Enable Go programming language

  # System Packages
  # ---------------
  # Additional packages installed globally on the system.
  
  environment.systemPackages = with pkgs; [
    brave  # Brave web browser
  ];

  # Example Environment Variables
  # Uncomment the following line to set the GTK theme to Adwaita dark mode.
  # environment.variables.GTK_THEME = "Adwaita:dark";

  # System State Version
  # --------------------
  # Set the system version to ensure compatibility with NixOS configurations.
  
  system.stateVersion = "24.05";  # Corresponds to NixOS 24.05

  # Example Program Configurations
  # Uncomment and configure as needed.

  # programs.mtr.enable = true;                         # Enables the MTR network diagnostic tool
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;                          # Enables SSH support with GPG agent
  # };

  # Example Services
  # Uncomment and configure as needed.
  
  # services.openssh.enable = true;                     # Enables SSH service for remote access
}