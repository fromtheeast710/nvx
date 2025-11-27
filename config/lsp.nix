{
  lsp = {
    inlayHints.enable = true;

    servers = {
      # jsonls.enable = true;
      # leanls.enable = true;
      # svelte.enable = true;
      just.enable = true;
      # ruff.enable = true;
      # tailwindcss.enable = true;
      scheme_langserver.enable = true;
      # svls.enable = true;
      # veryl_ls.enable = true;
      vhdl_ls.enable = true;
      # wasm_language_tools.enable = true;
      idris2_lsp.enable = true;
      lua_ls.enable = true;
      bashls.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      html.enable = true;
      rust_analyzer = {
        enable = true;
        settings = {
          check = {
            command = "clippy";
            features = "all";
            extraArgs = [
              "--"
              "--no-deps"
              "-Dclippy::correctness"
              "-Dclippy::complexity"
              "-Wclippy::perf"
              # "-Wclippy::pedantic"
            ];
          };
          procMacro = {
            ignored = {
              leptos_macro = [
                "component"
                "server"
              ];
            };
          };
        };
      };
      # ocamllsp.enable = true;
      tinymist.enable = true;
      hls.enable = true;
      asm-lsp.enable = true;
      nickel_ls = {
        enable = true;
        # autostart = true;
        # filetypes = ["nls"];
      };
      nixd = {
        enable = true;
        settings = {
          options.nixvim.expr = ''
            (builtins.getFlake "../flake.nix").packages.neovimNixvim.options
          '';
        };
      };
    };
  };
}
