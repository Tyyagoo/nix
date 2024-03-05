{ ... }: ''
  * {
    font-family: 'Iosevka Nerd Font';
    font-size: 15px;
    color: #151515;
  }

  window#waybar {
    background: transparent;
    margin: 10px 10px 0px 10px;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #workspaces {
    margin-left: 15px;
  }

  #clock {
    margin-right: 15px;
    padding: 0px 12px 0px 12px;
  }

  #workspaces,
  #clock {
    margin-top: 10px;
    margin-bottom: 3px;
    padding: 0px 6px 0px 6px;
    background: #F5EEE6;
    border: 1px solid #161616;
    border-radius: 12px;
    box-shadow: 0 0 2px black;
  }
''
