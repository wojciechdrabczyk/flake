{userConfig, pkgs, ...}: {
  services = {
    vscode-server.enable = true;
  };
  wsl = {
    enable = true;
    defaultUser = userConfig.userName;
    docker-desktop.enable = true;
  };
  networking.hostName = "wsl";
  services.mysql = {
    package = pkgs.mysql80;
    enable = true;
  };
}
