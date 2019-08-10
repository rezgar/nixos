{ lib, config, pkgs, ... }:
{
  services.urxvtd.enable = true;
  home.sessionVariables = {
    EDITOR = "urxvtc";
  };

  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config = let
    wsBrowserPersonal = ''1: Browser (Personal) '';
    wsBrowserWork = ''2: Browser (Work) '';
    wsTerminals = ''3: Terminals '';
    wsChat = ''4: Chat '';
    wsMail = ''5: Mail '';
    wsCode = ''6: Code '';
    wsVideo = ''7: Video '';
    wsAudio = ''8: Audio '';
    wsCustom = ''9: Custom'';

    fontsCommon = [ "FontAwesome 12" "monospace 12" "pango:DejaVu Sans Mono 12" "pango:System San Francisco Display 12" ];
    bgColor = "#2f343f";
    inactiveBgColor = "#2f343f";
    textColor = "#f3f4f5";
    inactiveTextColor = "#676e7d";
    urgentBgColor = "#e53935";
    indicator = "#00ff00";
  in rec {
    modifier = "Mod4";
    
    fonts = fontsCommon; 

    startup = [
      { command = "urxvtd --quiet --opendisplay --fork"; }
      { command = "--no-startup-id $HOME/Crossover/Crossover"; }
      { command = "--no-startup-id nm-applet"; }
      { command = "--no-startup-id flameshot"; }
      { command = "--no-startup-id i3-msg 'workspace ${wsBrowserPersonal}; exec 4< <(i3-get-conid -c \"Chromium\"); exec chromium --user-data-dir=~/.config/chromium/personal; exec i3-persist lock $(cat <&4);'"; }
      { command = "--no-startup-id i3-msg 'workspace ${wsBrowserWork}; exec 4< <(i3-get-conid -c \"Chromium\"); exec chromium --user-data-dir=~/.config/chromium/work; exec i3-persist lock $(cat <&4);'"; }
      { command = "i3-msg 'workspace ${wsTerminals}; exec urxvtc'"; }
      { command = "i3-msg 'workspace ${wsTerminals}; exec urxvtc'"; }
      { command = "i3-msg 'workspace ${wsTerminals}; exec urxvtc'"; }
      
      { command = "i3-msg 'workspace ${wsChat}; exec mattermost-desktop'"; }
      { command = "i3-msg 'workspace ${wsChat}; exec skypeforlinux'"; }
      { command = "i3-msg 'workspace ${wsChat}; exec slack'"; }
      { command = "i3-msg 'workspace ${wsChat}; exec pidgin'"; }
      { command = "i3-msg 'workspace ${wsChat}; exec zoom'"; }
      { command = "i3-msg 'workspace ${wsChat}; exec mattermost-desktop'"; }
    ];

    keybindings = lib.mkOptionDefault {
      "${modifier}+1" = "workspace ${wsBrowserPersonal}"; "${modifier}+Shift+1" = "move container to workspace ${wsBrowserPersonal}";
      "${modifier}+2" = "workspace ${wsBrowserWork}"; "${modifier}+Shift+2" = "move container to workspace ${wsBrowserWork}";
      "${modifier}+3" = "workspace ${wsTerminals}"; "${modifier}+Shift+3" = "move container to workspace ${wsTerminals}";
      "${modifier}+4" = "workspace ${wsChat}"; "${modifier}+Shift+4" = "move container to workspace ${wsChat}";
      "${modifier}+5" = "workspace ${wsMail}"; "${modifier}+Shift+5" = "move container to workspace ${wsMail}";
      "${modifier}+6" = "workspace ${wsCode}"; "${modifier}+Shift+6" = "move container to workspace ${wsCode}";
      "${modifier}+7" = "worskpace ${wsVideo}"; "${modifier}+Shift+7" = "move container to workspace ${wsVideo}";
      "${modifier}+8" = "workspace ${wsAudio}"; "${modifier}+Shift+8" = "move container to workspace ${wsAudio}";
      "${modifier}+9" = "worskpace ${wsCustom}"; "${modifier}+Shift+9" = "move container to workspace ${wsCustom}";

      "${modifier}+d" = ''exec rofi -show run -lines 3 -eh 2 -i \
                            -font "System San Francisco Display 18"
        '';
      "${modifier}+Shift+l" = "exec xset dpms force off && i3lock -d --color 000000";
      "${modifier}+i" = "scratchpad show";
    };

    assigns = {
      "${wsBrowserPersonal}" = [{ instance = "personal"; class = "Chromium";}];
      "${wsBrowserWork}" = [{instance = "work"; class = "Chromium";}];
      "${wsCode}" = [{class = "^Code$";}];
      "${wsChat}" = [
        {class = "Skype";}
        {class = "Slack";}
        {class = "Mattermost";}
        {class = "Pidgin";}
        {class = "zoom";}
      ];
      "${wsMail}" = [{title = "Thunderbird";}];
      "${wsVideo}" = [{class = "Popcorn-Time";}];
    };

    window = {
      commands = [
        { criteria = { title = "^Crossover$"; }; command = "move scratchpad"; }
        { criteria = { class = "Pidgin"; window_role = "conversation"; }; command = "floating enable, resize set 900 700, move absolute position center"; }
        { criteria = { class = "Gnome-calculator"; }; command = "floating enable, resize set 400 300, move absolute position center";}
        { criteria = { class = "^(?!URxvt).*"; }; command = "border pixel 1";}
      ];
    };

    colors = { 
      background = "${bgColor}";

      focused = {  
        border = "${bgColor}";
        background = "${bgColor}";
        text = "${textColor}";
        indicator = "${indicator}";
        childBorder = "${bgColor}";
      };
      focusedInactive = {
        border = "${inactiveBgColor}";
        background = "${inactiveBgColor}";
        text = "${inactiveTextColor}";
        indicator = "${indicator}";
        childBorder = "${bgColor}";
      };
      unfocused = {
        border = "${inactiveBgColor}";
        background = "${inactiveBgColor}";
        text = "${inactiveTextColor}";
        indicator = "${indicator}";
        childBorder = "${bgColor}";
      };
      urgent = {
        border = "${urgentBgColor}";
        background = "${urgentBgColor}";
        text = "${textColor}";
        indicator = "${indicator}";
        childBorder = "${bgColor}";
      };
    };

    bars = [{
      fonts = fontsCommon;
      colors = {
        background = "${bgColor}";
        focusedWorkspace = {
          border = "${bgColor}";
          background = "${bgColor}";
          text = "${textColor}";
        };
        inactiveWorkspace = {
          border = "${inactiveBgColor}";
          background = "${inactiveBgColor}";
          text = "${inactiveTextColor}";
        };
        urgentWorkspace = {
          border = "${urgentBgColor}";
          background = "${urgentBgColor}";
          text = "${textColor}";
        };
      };
    }];
  };
}
