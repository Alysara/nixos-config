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
        BetterFolders.enabled = true;
        MessageLatency.enabled = true;
        ShikiCodeBlocks.enabled = true;
        ShowHiddenThings.enabled = true;
        TypingTweaks.enabled = true;
        VolumeBooster.enabled = true;
        ClearURLs.enabled = true;
        ExpressionCloner.enabled = true;
        FriendsSize.enabled = true;
        MemberCount.enabled = true;
        MessageClickActions.enabled = true;
        NewGuildSettings.enabled = true;
        PlatformIndicators.enabled = true;
        RelationshipNotifier.enabled = true;
        SendTimestamps.enabled = true;
        ServerListIndicators.enabled = true;
        ShowHiddenChannels.enabled = true;
        TypingIndicator.enabled = true;
        ViewIcons.enabled = true;
        WhoReacted.enabled = true;
        YoutubeAdblock.enabled = true;
      };
    };
  };
}