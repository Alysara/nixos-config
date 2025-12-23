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
        FriendsSince.enabled = true;
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
        BetterGifPicker.enabled = true;
        FavoriteGifSearch.enabled = true;
        BetterSessions.enabled = true;
        BetterSettings.enabled = true;
        CallTimer.enabled = true;
        ImplicitRelationships.enabled = true;
        AlwaysExpandRoles.enabled = true;
        AlwaysTrust.enabled = true;
        PlainFolderIcon.enabled = true;
        DisableCallIdle.enabled = true;
        VoiceMessages.enabled = true;
        CustomRPC.enabled = true;
      };
    };
  };
}