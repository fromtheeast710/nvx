{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins;
    [
      mini-files
      bigfile-nvim
      nvim-comment
      vim-startuptime
      diagflow-nvim
    ]
    ++ (with pkgs.vimUtils; [
      (buildVimPlugin rec {
        pname = "spaceless.nvim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "lewis6991";
          repo = pname;
          rev = "927fb0afb416ea39306af5842c247d810dfd5938";
          hash = "sha256-t9wZ6ZYS42BDkJ2wcphcgqLobThyiCfGwhBVTdX7iGQ=";
        };
      })
      # (buildVimPlugin rec {
      #   pname = "nvim-agda";
      #   version = "unstable";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "ashinkarov";
      #     repo = pname;
      #     rev = "9024909ac5cbac0a0b6f1f3f7f2b65c907c8fc12";
      #     hash = "";
      #   };
      # })
    ]);

  extraConfigLua = builtins.readFile ./extra.lua;
}
