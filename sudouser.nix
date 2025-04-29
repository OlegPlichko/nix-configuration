# Edit this configuration file to define uiser with password and sudo privileges

{ config, lib, pkgs, ... }:

{
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    password = "YOUR_PASSWORD_HERE";
    packages = with pkgs; [
      vim
    ];
  };

  # Allow sudo without password (optional)
  security.sudo.wheelNeedsPassword = false;
}
