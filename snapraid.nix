{ config, pkgs, lib, ... }:

let
  snapraidConf = pkgs.writeText "snapraid.conf" ''
    # Data disks
    data /mnt/Storage1

    # Parity disk
    parity /mnt/Storage2

    # Content files
    content /mnt/Storage1/snapraid.content
    content /var/snapraid.content

    # Excludes
    exclude *.unrecoverable
    exclude /lost+found/
    exclude *.!sync
    exclude /tmp/
  '';
in
{
  environment.systemPackages = with pkgs; [
    snapraid
  ];

  # Add SnapRAID config at /etc/snapraid.conf
  environment.etc."snapraid.conf".source = snapraidConf;

  # Schedule scrub via cron (e.g., 5:00 AM every Thursday)
  services.cron.enable = true;
  services.cron.systemCronJobs = [
    "0 5 * * 4 root ${pkgs.snapraid}/bin/snapraid scrub"
  ];
}
