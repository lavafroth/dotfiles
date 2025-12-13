{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arti
    brave
    ungoogled-chromium
  ];

 
  # librewolf styling
  home.file.".librewolf/default/chrome/userChrome.css".source = ./sources/userChrome.css;
  programs.librewolf = {
    enable = true;
    settings = {
      "ui.key.menuAccessKeyFocuses" = false;
      "accessibility.typeaheadfind" = true;
      "accessibility.typeaheadfind.enablesound" = false;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.revamp.round-content-area" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.uiCustomization.state" = ''
      {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","urlbar-container","vertical-spacer","unified-extensions-button","dearrow_ajay_app-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","screenshot-button","ublock0_raymondhill_net-browser-action","sponsorblocker_ajay_app-browser-action","dearrow_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","toolbar-menubar","PersonalToolbar","unified-extensions-area"],"currentVersion":23,"newElementCount":3}
      '';
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
