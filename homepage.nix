{ config, pkgs, ... }:

{
  # Ensure homepage-dashboard is available
  environment.systemPackages = with pkgs; [
    homepage-dashboard
  ];

  # Create a systemd service to run homepage-dashboard
  systemd.services.homepage-dashboard = {
    description = "Homepage Dashboard";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.homepage-dashboard}/bin/homepage";
      Restart = "always";
      User = "homepage";
      WorkingDirectory = "/var/lib/homepage";
    };

    # Ensure the directory exists
    preStart = ''
      mkdir -p /var/lib/homepage
      chown homepage:homepage /var/lib/homepage
    '';
  };

  # Create the user that runs the service
  users.users.homepage = {
    isSystemUser = true;
    home = "/var/lib/homepage";
    createHome = true;
    group = "homepage";
  };

  users.groups.homepage = {};
  networking.firewall.allowedTCPPorts = [ 3000 ];
}

