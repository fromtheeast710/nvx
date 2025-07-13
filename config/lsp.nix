{pkgs, ...}: {
  lsp = {
    # enable = true;
    inlayHints.enable = true;
    # keymaps = {
    #   diagnostic = {
    #     "<leader>j" = "goto_next";
    #     "<leader>k" = "goto_prev";
    #   };
    #   lspBuf = {
    #     K = "hover";
    #     gD = "references";
    #     gd = "definition";
    #     gi = "implementation";
    #     gt = "type_definition";
    #   };
    # };
    servers = {
      jsonls.enable = true;
      tailwindcss.enable = true;
      svelte.enable = true;
      idris2_lsp.enable = true;
      just.enable = true;
      nickel_ls.enable = true;
      lua_ls.enable = true;
      bashls.enable = true;
      rust_analyzer.enable = true;
      ocamllsp.enable = true;
      tinymist.enable = true;
      # leanls.enable = true;
      nixd = {
        enable = true;
        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
        };
      };
    };
  };
}
