{userConfig, ...}: {
  programs.git = {
    enable = true;
    userName = userConfig.fullName;
    userEmail = userConfig.userEmail;
  };
}
