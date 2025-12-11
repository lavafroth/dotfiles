{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arti
    brave
    ungoogled-chromium
  ];

  programs.librewolf = {
    enable = true;
    settings = {
      "ui.key.menuAccessKeyFocuses" = false;
      "accessibility.typeaheadfind" = true;
      "accessibility.typeaheadfind.enablesound" = false;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.revamp.round-content-area" = true;
    };

    profiles.default.search = {
      force = true;
      default = "udm14";
      privateDefault = "ddg";

      engines = {
        "udm14" = {
          urls = [
            {
              template = "https://google.com/search";
              params = [
                {
                  name = "udm";
                  value = "14";
                }
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@udm14" ];
        };
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixpkgs" ];
        };

        "Nix Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixopts" ];
        };

        "NixOS Wiki" = {
          urls = [
            {
              template = "https://wiki.nixos.org/w/index.php";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixwiki" ];
        };
      };
    };

  };
}
