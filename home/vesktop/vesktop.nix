{ pkgs, ... }:

{
  xdg.configFile."vesktop/settings/quickCss.css".source = ./quick.css;
  programs.vesktop = {
    enable = true;

    settings = {
      appBadge = false;
      tray = false;
    };

    vencord.settings = {
      transparent = true;
      plugins = {
        BetterFolders.enable = true;
        MessageLatency.enable = true;
        ShikiCodeBlocks.enable = true;
        ShowHiddenThings.enable = true;
        TypingTweaks.enable = true;
        VolumeBooster.enable = true;
        ClearURLs.enable = true;
        ExpressionCloner.enable = true;
        FriendsSize.enable = true;
        MemberCount.enable = true;
        MessageClickActions.enable = true;
        NewGuildSettings.enable = true;
        PlatformIndicators.enable = true;
        RelationshipNotifier.enable = true;
        SendTimestamps.enable = true;
        ServerListIndicators.enable = true;
        ShowHiddenChannels.enable = true;
        TypingIndicator.enable = true;
        ViewIcons.enable = true;
        WhoReacted.enable = true;
        YoutubeAdblock.enable = true;
      };
    };
  };
}