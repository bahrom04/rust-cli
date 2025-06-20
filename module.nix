flake: {
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.uzbekl10nbot;
  pkgs = flake.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  options = {
    services.uzbekl10nbot = {
      enable = lib.mkEnableOption "uzbekl10bot";

      token = lib.mkOption {
        type = lib.types.str;
        description = "This is telegram bot token taken from botFather";
      };

      system_user = lib.mkOption {
        type = lib.types.str;
        description = "User of your system example: bahrom04";
      };

      home_dir = lib.mkOption {
        type = lib.types.str;
        description = "Home path of your system example: /Users/bahrom04 or in linux /home/bahrom04";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # NixOS
    # systemd.services.uzbekl10nbot = {
    #   name = "uzbekl10nbot";
    #   documentation = [""];
    #   wantedBy = ["multi-user.target"];

    #   #environment = {
    #   # LANG = "nl_NL.UTF-8";
    #   # PATH = "/foo/bar/bin";
    #   # };
      
    #   serviceConfig = {
    #     Restart = "always";
    #     RestartSec = 5;
    #     ExecStart = ''
    #     ${pkgs}/bin/rust-cli --token=${cfg.token}
    #     '';
    #   };
    # };

    # MacOS
    launchd.users.agents = {
      uzbekl10nbot = {
        serviceConfig = {
          ProgramArguments = [
            "${pkgs}/bin/rust-cli"
            "--token=${cfg.token}"
          ];
          StandartOutPath = "${cfg.home_dir}/Library/Logs/uzbekl10nbot.log"; 
          StandartErrorPath = "${cfg.home_dir}/Library/Logs/uzbekl10nbot_error.log"; 
          KeepAlive = true;
          RunAtLoad = true;
        };
      };
    };
  };
}
