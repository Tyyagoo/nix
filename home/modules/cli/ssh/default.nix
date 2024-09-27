{ config, lib, pkgs, namespace, ... }: {
  programs.ssh = {
    enable = true;
    userKnownHostsFile = "~/.ssh/known_hosts.d/hosts";
    # TODO: keys
  };
}
