{pkgs, ...}: {
  # environment.systemPackages = with pkgs; [
  # polkit_gnome
  # ];

  security = {
    polkit.enable = true;
    wrappers.dumpcap = {
      source = "${pkgs.wireshark}/bin/dumpcap";
      capabilities = "cap_net_raw,cap_net_admin+ep";
      owner = "root";
      group = "wireshark";
    };
  };

  systemd = {
    user.services.polkit-pantheon-authentication-agent-1 = {
      description = "Pantheon PolicyKit agent";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };

      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
    };
  };

  # systemd = {
  # user.services.polkit-gnome-authentication-agent-1 = {
  # description = "polkit-gnome-authentication-agent-1";
  # wantedBy = ["graphical-session.target"];
  # wants = ["graphical-session.target"];
  # after = ["graphical-session.target"];
  # serviceConfig = {
  # Type = "simple";
  # ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  # Restart = "on-failure";
  # RestartSec = 1;
  # TimeoutStopSec = 10;
  # };
  # };
  # };
}
