{
  lsp = {
    inlayHints.enable = true;

    servers = {
      # jsonls.enable = true;
      # leanls.enable = true;
      # svelte.enable = true;
      just.enable = true;
      tailwindcss.enable = true;
      idris2_lsp.enable = true;
      lua_ls.enable = true;
      bashls.enable = true;
      rust_analyzer.enable = true;
      ocamllsp.enable = true;
      tinymist.enable = true;
      hls.enable = true;
      nickel_ls = {
        enable = true;
        # autostart = true;
        # filetypes = ["nls"];
      };
      nixd = {
        enable = true;
        settings = {
          options.nixvim.expr = /* nix */ ''
            (builtins.getFlake "../flake.nix").packages.neovimNixvim.options
          '';
        };
      };
    };
  };
}
