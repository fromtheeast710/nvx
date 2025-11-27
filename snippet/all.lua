local ls = require "luasnip"
local extras = require("luasnip.extras")
-- BUG: https://github.com/nix-community/nixvim/issues/3973
local fmt = require("luasnip.extras.fmt").fmt
local r = extras.rep
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

vim.keymap.set({ "i", "s" }, "<A-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

vim.keymap.set({ "i", "s" }, "<A-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

ls.add_snippets("vhdl", {
  s("ie", t { "library ieee;", "use ieee.std_logic_1164.all;" }),

  s("en", fmt([[
    entity {} is
      generic ( {} );
      port ( {} );
    end;

    architecture {} of {} is
      {}
    begin
      {}
    end;
  ]], { i(1), i(2), i(3), i(4, "main"), r(1), i(5), i(6) })),

  s("fn", fmt([[
    function {} return {} is
      {}
    begin
      {}
    end function;
  ]], { i(1), i(2), i(3), i(0) })),

  s("if", fmt([[
    if {} then
      {}
    else
      {}
    end if;
  ]], { i(1), i(2), i(0) })),

  s("pr", fmt([[
    process ( {} ) is
      {}
    begin
      {}
    end process;
  ]], { i(1), i(2), i(0) })),
})
