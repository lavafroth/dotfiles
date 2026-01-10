{ pkgs, ... }:
{
  home.packages = with pkgs; [
    arti
    brave
    ungoogled-chromium
  ];

  # https://nix-community.github.io/stylix/options/modules/firefox.html
  stylix.targets.librewolf.profileNames = [ "default" ];

  # librewolf styling
  home.file.".librewolf/default/chrome/userChrome.css".source = ./sources/userChrome.css;
  programs.librewolf = {
    enable = true;
    settings = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "ui.key.menuAccessKeyFocuses" = false;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.revamp.round-content-area" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.ml.enable" = false;
      "browser.uiCustomization.state" = ''
        {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","urlbar-container","vertical-spacer","unified-extensions-button","dearrow_ajay_app-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","screenshot-button","ublock0_raymondhill_net-browser-action","sponsorblocker_ajay_app-browser-action","dearrow_ajay_app-browser-action"],"dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","toolbar-menubar","PersonalToolbar","unified-extensions-area"],"currentVersion":23,"newElementCount":3}
      '';
    };

    profiles.eep = {
      id = 1;
      settings = {
        "network.proxy.http" = "localhost";
        "network.proxy.http_port" = 4444;
        "network.proxy.ssl" = "localhost";
        "network.proxy.ssl_port" = 4444;
        "network.proxy.type" = 1; # manual proxy
        "media.peerconnection.ice.proxy_only" = true;
        "browser.urlbar.autoFill" = false;

        "browser.fixup.fallback-to-https" = false;
        "network.stricttransportsecurity.preloadlist" = false;
        "browser.fixup.domainsuffixwhitelist.i2p" = true;
        "dom.security.https_only_mode_ever_enabled" = false;
      };

      bookmarks.force = true;
      bookmarks.settings = [
        {
          name = "router";
          url = "http://localhost:7070/";
        }
      ];
    };

    profiles.arti = {
      id = 2;
      settings = {
        "network.proxy.socks" = "localhost";
        "network.proxy.socks_port" = 9150;
        "network.proxy.type" = 1; # manual proxy
        "network.proxy.socks5_remote_dns" = true;
      };
    };

    profiles.default.search = {
      force = true;
      default = "ddg";
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

        "sklearn" = {
          urls = [
            {
              template = "https://scikit-learn.org/stable/search.html";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@sklearn" ];
        };

        "torch" = {
          urls = [
            {
              template = "https://docs.pytorch.org/docs/2.9/search.html";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@torch" ];
        };

        "docs.rs" = {
          urls = [
            {
              template = "https://docs.rs/releases/search";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@docsrs" ];
        };

      };
    };

  };
}
