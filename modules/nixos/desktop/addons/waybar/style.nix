# Source
# https://github.com/i4pg/dotfiles/blob/fbad3f0135621dfe3534ea38fdb7db0a9936c783/private_dot_config/waybar/style2.css

{ ... }: ''
  @import "./mocha.css";
  
  /* Global */
  * {
    font-family: "Iosevka Nerd Font";
    font-size: .9rem;
    border-radius: 1rem;
    transition-property: background-color;
    transition-duration: 0.5s;
    background-color: shade(@base, 0.9);
    color: @text;
  }
  
  @keyframes blink_red {
    to {
      background-color: @red;
      color: @base;
    }
  }
  
  @keyframes blink_yellow {
    to {
      background-color: @yellow;
      color: @base;
    }
  }
  
  .warning {
    animation-name: blink_yellow;
    animation-duration: 1s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }
  
  .critical, .urgent {
    animation-name: blink_red;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }
  
  #clock, #memory, #temperature, #cpu, #custom-weather,
  #mpd, #idle_inhibitor, #pulseaudio, #network, 
  #battery, #custom-powermenu, #cava,
  #custom-launcher, #tray, #disk {
    padding-left: .6rem;
    padding-right: .6rem;
  }
  
  /* Bar */
  window#waybar {
    background-color: transparent;
  }
  
  window > box {
    background-color: transparent;
    margin: .3rem;
    margin-bottom: 0;
  }
  
  
  /* Workspaces */
  #workspaces button {
    padding-right: .4rem;
    padding-left: .4rem;
    padding-top: .1rem;
    padding-bottom: .1rem;
    color: @text;
    background: transparent;
    transition: all ease 0.6s;
  }
  
  /* Tooltip */
  tooltip {
    background-color: @base;
  }
  
  tooltip label {
    color: @rosewater;
  }
  
  /* battery */
  #battery {
    color: @mauve;
  }
  #battery.full {
    color: @green;
  }
  #battery.charging{
    color: @teal;
  }
  #battery.discharging {
    color: @peach;
  }
  #battery.critical:not(.charging) {
    color: @pink;
  }
  #custom-powermenu {
    color: @red;
  }
  
  /* mpd */
  #mpd.paused {
    color: @pink;
    font-style: italic;
  }
  #mpd.stopped {
    color: @rosewater;
    /* background: transparent; */
  }
  #mpd {
    color: @lavender;
  }
  
  /* Extra */
  #cava {
    color: @peach;
    padding-right: 1rem;
  }
  #custom-launcher {
    color: @yellow;
  }
  #memory {
    color: @peach;
  }
  #cpu {
    color: @blue;
  }
  #clock {
    color: @rosewater;
  }
  #idle_inhibitor {
    color: @green;
  }
  #temperature {
    color: @sapphire;
  }
  #pulseaudio {
    color: @mauve;  /* not active */
  }
  #network {
    color: @pink; /* not active */
  }
  #network.disconnected {
    color: @foreground;  /* not active */
  }
  #disk {
    color: @maroon;
  }
  #custom-weather {
    color: @red;
  }
''
