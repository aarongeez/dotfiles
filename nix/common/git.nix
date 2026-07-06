{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "parth";
      user.email = "parth@mehrotra.me";
      push.default = "current";
      pull.default = "current";
      branch.autoSetupMerge = "true";
    };
  };
}
