{
  luaLoader.enable = false;

  performance = {
    combinePlugins = {
      enable = true;
      standalonePlugins = [
        "onedark.nvim"
        "typst-preview.nvim"
      ];
    };
    byteCompileLua = {
      enable = true;
      initLua = true;
      luaLib = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
